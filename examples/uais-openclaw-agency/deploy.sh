#!/bin/bash
# ============================================================
# Paperclip Business Deployer
# ============================================================
# Deploys any business model from this repo to a Paperclip instance.
#
# Usage:
#   bash deploy.sh                    # Interactive mode
#   bash deploy.sh /path/to/example   # Deploy specific example
#
# Prerequisites:
#   - Paperclip running at localhost:3100
#   - OpenCode installed (npm install -g @anthropic/opencode)
#   - OpenRouter API key set
#   - jq installed (for JSON parsing)
# ============================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

API="http://localhost:3100/api"

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Paperclip Business Deployer${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# ----------------------------------------------------------
# Determine business directory
# ----------------------------------------------------------
if [ -n "${1:-}" ]; then
  BIZ_DIR="$1"
else
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  REPO_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
  echo "Available business models:"
  echo ""
  for dir in "$REPO_DIR/examples"/*/; do
    if [ -f "$dir/config/company.json" ]; then
      NAME=$(jq -r '.company_name' "$dir/config/company.json" 2>/dev/null || basename "$dir")
      MISSION=$(jq -r '.mission' "$dir/config/company.json" 2>/dev/null || "No description")
      echo -e "  ${GREEN}$(basename "$dir")${NC}"
      echo -e "    $NAME: $MISSION"
      echo ""
    fi
  done
  echo -n "Enter example folder name (e.g., uais-openclaw-agency): "
  read CHOICE
  BIZ_DIR="$REPO_DIR/examples/$CHOICE"
fi

if [ ! -f "$BIZ_DIR/config/company.json" ]; then
  echo -e "${RED}ERROR: No company.json found at $BIZ_DIR/config/company.json${NC}"
  exit 1
fi

COMPANY=$(jq -r '.company_name' "$BIZ_DIR/config/company.json")
MISSION=$(jq -r '.mission' "$BIZ_DIR/config/company.json")

echo -e "${GREEN}Deploying: $COMPANY${NC}"
echo -e "Mission: $MISSION"
echo ""

# ----------------------------------------------------------
# Step 1: Health Check
# ----------------------------------------------------------
echo -e "${BLUE}[1/5] Checking Paperclip...${NC}"
if curl -sf "$API/health" > /dev/null 2>&1; then
  echo -e "  ${GREEN}Paperclip is running.${NC}"
else
  echo -e "  ${RED}Paperclip is not running at $API${NC}"
  echo "  Start it with: npx paperclipai onboard --yes"
  exit 1
fi

# ----------------------------------------------------------
# Step 2: Check OpenCode
# ----------------------------------------------------------
echo -e "${BLUE}[2/5] Checking OpenCode...${NC}"
if command -v opencode &> /dev/null; then
  echo -e "  ${GREEN}OpenCode is installed.${NC}"
else
  echo -e "  ${YELLOW}OpenCode not found. Install with: npm install -g @anthropic/opencode${NC}"
fi

# Check OpenRouter config
OPENCODE_CONFIG="$HOME/.config/opencode/opencode.json"
if [ -f "$OPENCODE_CONFIG" ]; then
  echo -e "  ${GREEN}OpenCode config found at $OPENCODE_CONFIG${NC}"
else
  echo -e "  ${YELLOW}No OpenCode config found. Creating from template...${NC}"
  mkdir -p "$HOME/.config/opencode"
  cp "$BIZ_DIR/../template/config/opencode.json" "$OPENCODE_CONFIG" 2>/dev/null || \
  cp "$(dirname "$0")/../config/opencode.json" "$OPENCODE_CONFIG" 2>/dev/null || \
  echo '{"providers":{"openrouter":{"apiKey":"YOUR_OPENROUTER_API_KEY"}},"models":{"kimi-k2.5":{"provider":"openrouter","id":"moonshotai/kimi-k2.5"}}}' > "$OPENCODE_CONFIG"
  echo -e "  ${YELLOW}IMPORTANT: Edit $OPENCODE_CONFIG and add your OpenRouter API key${NC}"
fi

# ----------------------------------------------------------
# Step 3: Create Goals
# ----------------------------------------------------------
echo -e "${BLUE}[3/5] Creating company goals...${NC}"

GOAL=$(jq -r '.ninety_day_goal // .["90_day_goal"] // "Achieve target MRR"' "$BIZ_DIR/config/company.json")
P1=$(jq -r '.products[0].name // "Product 1"' "$BIZ_DIR/config/company.json")
P2=$(jq -r '.products[1].name // "Product 2"' "$BIZ_DIR/config/company.json")
V1=$(jq -r '.verticals[0] // "Vertical 1"' "$BIZ_DIR/config/company.json")
V2=$(jq -r '.verticals[1] // "Vertical 2"' "$BIZ_DIR/config/company.json")
V3=$(jq -r '.verticals[2] // "Vertical 3"' "$BIZ_DIR/config/company.json")

echo "  Company Goal: $GOAL"
echo "  Products: $P1 + $P2"
echo "  Verticals: $V1, $V2, $V3"
echo ""

# Try to create goals via CLI if available
if command -v pnpm &> /dev/null && [ -d "$HOME/paperclip" ]; then
  COMPANY_ID=$(curl -sf "$API/companies" | jq -r '.[0].id // empty' 2>/dev/null || echo "")
  if [ -n "$COMPANY_ID" ]; then
    echo "  Found company: $COMPANY_ID"
    pnpm --dir "$HOME/paperclip" paperclipai issue create \
      --company-id "$COMPANY_ID" \
      --title "GOAL: $GOAL" \
      --description "90-day company objective. Products: $P1, $P2. Verticals: $V1, $V2, $V3." \
      2>/dev/null && echo -e "  ${GREEN}Goal created.${NC}" || echo "  (Create goal manually in dashboard)"
  else
    echo -e "  ${YELLOW}No company found. Create one in the dashboard first.${NC}"
  fi
else
  echo -e "  ${YELLOW}Create goals manually in the Paperclip dashboard.${NC}"
fi

# ----------------------------------------------------------
# Step 4: Agent Setup Instructions
# ----------------------------------------------------------
echo ""
echo -e "${BLUE}[4/5] Agent configuration:${NC}"
echo ""
echo -e "  For each agent in Paperclip, do the following:"
echo ""

for prompt_file in "$BIZ_DIR/agents/"*.md; do
  AGENT_NAME=$(head -1 "$prompt_file" | sed 's/^# //' | sed 's/Agent [0-9]*: //')
  BUDGET=$(grep -oP 'budgetMonthlyCents.*?(\d+)' "$prompt_file" | grep -oP '\d+' | head -1 || echo "2500")
  HEARTBEAT=$(grep -i 'heartbeat' "$prompt_file" | head -1 | grep -oP 'Every \S+ \S+' || echo "see file")

  echo -e "  ${GREEN}$AGENT_NAME${NC}"
  echo "    Adapter: OpenCode (local) | Model: kimi-k2.5"
  echo "    Budget: \$$(echo "scale=0; $BUDGET / 100" | bc)/mo | Heartbeat: $HEARTBEAT"
  echo "    Prompt: $prompt_file"
  echo ""
done

# ----------------------------------------------------------
# Step 5: Summary
# ----------------------------------------------------------
echo -e "${BLUE}[5/5] Deployment checklist:${NC}"
echo ""
echo "  [ ] Paperclip running at localhost:3100"
echo "  [ ] Company created in dashboard with mission"
echo "  [ ] OpenRouter API key in ~/.config/opencode/opencode.json"
echo "  [ ] Calendar booking link ready (replace {{CALENDAR_LINK}} in prompts)"
echo "  [ ] Email sending domains warming in Instantly"
echo "  [ ] All 9 agents created with:"
echo "      [ ] Adapter: OpenCode (local)"
echo "      [ ] Instructions: pasted from agents/ folder"
echo "      [ ] Budget: set per agent"
echo "      [ ] Heartbeat: set per agent"
echo "  [ ] Agents activated"
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Deploy complete. Activate agents to start.${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "  Dashboard: http://localhost:3100"
echo "  Agent prompts: $BIZ_DIR/agents/"
echo ""
