# Paperclip Autonomous Businesses — Setup Walkthrough

> **To install:** Open Claude Code in this folder and type `set this up for me` or `/walkthrough`

Claude Code will read this repo's actual files and walk you through every step interactively — choosing a business model, configuring the 9 agents, deploying to Paperclip, and activating your autonomous business.

---

## What This Repo Does

Deploy a fully autonomous AI-powered business on [Paperclip](https://paperclip.ing) in minutes. Each business runs 9 AI agents on OpenCode + kimi-k2.5 via OpenRouter — a CEO, CMO, COO, VP Sales, Social Media Manager, Operations Specialist, and 3 SDRs handling prospecting, cold outreach, and warm nurture. Two example businesses included: a UAIS/OpenClaw agency and an AI Go-To-Market Agency. AI costs under $5/day. You take demo calls. Agents handle everything else.

---

## Prerequisites

- **Paperclip account** — paperclip.ing (the agent orchestration platform)
- **OpenRouter account** — for kimi-k2.5 model access (openrouter.ai)
- **Claude Code** — Anthropic's CLI for orchestrating the deployment
- **GitHub account** — optional, for version-controlling your business configs

---

## Environment Variables

Configuration lives in `template/config/company.json` and `template/config/opencode.json`:

| Config File | Key Settings |
|-------------|-------------|
| `company.json` | Company name, offer, target market, pricing, sales scripts |
| `opencode.json` | OpenRouter API key, model selection (kimi-k2.5), rate limits |
| `heartbeats.json` | Agent heartbeat schedule — how often each agent checks in |

For each example business, copy the config:
```bash
cp examples/uais-openclaw-agency/config/company.json config/
# or
cp examples/ai-gtm-agency/config/company.json config/
```

---

## Quick Setup

```bash
# 1. Pick your business model
ls examples/
# Options: uais-openclaw-agency, ai-gtm-agency

# 2. Run the deploy script
bash template/scripts/deploy.sh

# 3. Open Paperclip dashboard
open https://paperclip.ing

# 4. Paste each agent's instructions into Paperclip
# (deploy.sh outputs formatted instructions for all 9 agents)

# 5. Activate agents — the business runs itself
```

For a guided walkthrough including Paperclip account setup, OpenRouter configuration, and agent activation — open Claude Code and type `/walkthrough`.

---

## The 9 Agents (Per Business)

| # | Agent | What It Does |
|---|-------|-------------|
| 1 | **CEO** | Orchestrates all other agents, sets weekly priorities, owns top-line metrics |
| 2 | **CMO** | Content strategy, social media calendar, brand voice |
| 3 | **COO** | Operations, systems, quality control, delivery |
| 4 | **VP Sales** | Sales process, pipeline management, close strategy |
| 5 | **Social Media Manager** | Executes content calendar, monitors engagement |
| 6 | **Operations Specialist** | Client delivery, onboarding, fulfillment |
| 7 | **SDR: LinkedIn/Social** | LinkedIn outreach, connection requests, DM sequences |
| 8 | **SDR: Cold Outreach** | Email prospecting, sequences, inbox management |
| 9 | **SDR: Warm Nurture** | Follow-up sequences, reactivation, relationship management |

---

## Creating a New Business Model

To build a custom business beyond the two examples:

1. Copy `template/` to a new folder: `cp -r template examples/your-business/`
2. Edit `config/company.json` — your company name, offer, ICP, pricing
3. Customize each `agents/*.md` file with your business context
4. Run `bash template/scripts/deploy.sh` from your new folder

See `template/TEMPLATE.md` for the full business creation guide.

---

## Key Commands

| Command | What It Does |
|---------|-------------|
| `bash template/scripts/deploy.sh` | Deploy chosen business to Paperclip |
| `ls examples/` | List available business models |
| `cat examples/uais-openclaw-agency/README.md` | Read UAIS/OpenClaw agency details |
| `cat examples/ai-gtm-agency/README.md` | Read AI GTM agency details |

---

## What You Actually Do (Minimal Hands-On)

Once deployed and activated:
- Check Paperclip dashboard daily (5 minutes)
- Take demo calls that the SDR agents book
- Review weekly CEO agent reports
- Approve major decisions flagged by the agents

The agents handle: prospecting, outreach, follow-up, content, operations, and delivery.

---

*This file was deployed by [AGI-1](https://github.com/jbellsolutions/agi-1) — the self-healing, self-learning AI development framework.*
