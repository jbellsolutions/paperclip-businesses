# How to Create Your Own Autonomous Business

This template gives you the scaffolding to spin up any business on Paperclip with 9 AI agents running on OpenCode + kimi-k2.5.

## Step 1: Define Your Business

Fill out `config/company.json` with:

```json
{
  "company_name": "Your Company Name",
  "mission": "One sentence. What does this company do and what's the 90-day target?",
  "products": [
    {
      "name": "Entry Product",
      "description": "What it is",
      "pricing": "$X upfront / trial / $X/mo retainer",
      "delivery_days": 7,
      "target_customer": "Who buys this"
    },
    {
      "name": "Upsell Product",
      "description": "What it is",
      "pricing": "$X setup + $X/mo",
      "delivery_days": 21,
      "target_customer": "Who buys this"
    }
  ],
  "cross_sell": "Optional additional service",
  "verticals": ["Vertical 1", "Vertical 2", "Vertical 3"],
  "calendar_link": "https://calendly.com/your-link",
  "email_domain": "your-sending-domain.com",
  "openrouter_model": "moonshotai/kimi-k2.5"
}
```

## Step 2: Customize Agent Prompts

Copy the 9 agent files from `agents/` into your business folder. Each file has placeholder sections marked with `{{PLACEHOLDER}}` that you replace:

| Placeholder | Replace With |
|------------|-------------|
| `{{COMPANY_NAME}}` | Your company name |
| `{{MISSION}}` | Your 90-day mission |
| `{{PRODUCT_1_NAME}}` | Entry product name |
| `{{PRODUCT_1_PITCH}}` | One-line pitch for product 1 |
| `{{PRODUCT_1_PRICING}}` | Pricing structure |
| `{{PRODUCT_2_NAME}}` | Upsell product name |
| `{{PRODUCT_2_PITCH}}` | One-line pitch for product 2 |
| `{{PRODUCT_2_PRICING}}` | Pricing structure |
| `{{CROSS_SELL}}` | Cross-sell offer |
| `{{VERTICAL_1}}` | First target vertical |
| `{{VERTICAL_2}}` | Second target vertical |
| `{{VERTICAL_3}}` | Third target vertical |
| `{{PAIN_POINT_1}}` | Top pain point for targets |
| `{{PAIN_POINT_2}}` | Second pain point |
| `{{PAIN_POINT_3}}` | Third pain point |
| `{{PROOF_POINT}}` | Social proof / case study stat |
| `{{CALENDAR_LINK}}` | Your booking link |
| `{{COMPANY_EMAIL}}` | Your outreach email |

## Step 3: Configure OpenCode

Edit `config/opencode.json` with your OpenRouter API key:

```json
{
  "providers": {
    "openrouter": {
      "apiKey": "YOUR_OPENROUTER_API_KEY"
    }
  },
  "models": {
    "kimi-k2.5": {
      "provider": "openrouter",
      "id": "moonshotai/kimi-k2.5"
    }
  }
}
```

## Step 4: Deploy

```bash
bash scripts/deploy.sh
```

This will:
1. Check Paperclip is running
2. Check OpenCode is configured
3. Create the company goals in Paperclip
4. Print instructions for creating each agent
5. Verify the setup

## Step 5: Paste Prompts and Activate

For each of the 9 agents in Paperclip:
1. Go to the agent's **Configuration** tab
2. Set adapter to **OpenCode (local)**
3. Go to the **Instructions** tab
4. Paste the corresponding prompt from your `agents/` folder
5. Go to the **Budget** tab and set the monthly budget
6. Activate the agent

## The 9-Agent Structure

Every business uses the same org structure:

```
BOARD (You)
    └── CEO (strategy, reporting, resource allocation)
        ├── CMO (brand, content, email sequences, collateral)
        │   └── Social Media Manager (posting, engagement, influencer scraping)
        ├── COO (delivery, infrastructure, product development)
        │   └── Operations Specialist (builds, onboarding, support)
        └── VP Sales (pipeline, coaching, conversion tracking)
            ├── SDR LinkedIn & Social (connections, DMs, warm leads)
            ├── SDR Cold Outreach (email, call, text first-touch)
            └── SDR Warm & Nurture (follow-up, re-engage, convert)
```

This structure works for any B2B service business. The agents handle:
- **Frontend** (lead gen + appointment booking): CMO, Social Media Manager, VP Sales, 3 SDRs
- **Backend** (delivery + operations): COO, Operations Specialist
- **Oversight** (strategy + reporting): CEO

## Budget Guide

| Agent | Budget | Heartbeat |
|-------|--------|-----------|
| CEO | $50/mo | Every 4 hours |
| CMO | $30/mo | Every 6 hours |
| COO | $40/mo | Every 4 hours |
| VP Sales | $40/mo | Every 2 hours |
| Social Media Manager | $25/mo | Every 2 hours |
| Operations Specialist | $25/mo | Every 4 hours |
| SDR LinkedIn & Social | $25/mo | Every 1 hour |
| SDR Cold Outreach | $25/mo | Every 1 hour |
| SDR Warm & Nurture | $25/mo | Every 2 hours |
| **Total** | **$285/mo** | |

These are budget caps in Paperclip. Actual token costs with kimi-k2.5 via OpenRouter will be much lower (typically $15-50/mo total).
