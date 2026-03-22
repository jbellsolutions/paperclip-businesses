# Using AI To Scale (UAIS) - OpenClaw Agency Example

This is a complete, filled-in example of an autonomous business selling managed AI assistant packages using the Paperclip framework.

## What UAIS Does

Using AI To Scale is a B2B SaaS agency that sells two products:

1. **OpenClaw Agent Setup** ($2K-$2.5K/mo): Single managed AI assistant on Orgo VM
   - Handles inbound lead capture, qualification, and follow-up
   - 7-day deployment
   - Target: Staffing Agencies, Home Services, Insurance Agencies

2. **Autonomous Business System** ($5K-$10K setup + $3K-$5K/mo): Full Paperclip deployment
   - CEO + CMO + COO + VP Sales + 3 SDRs
   - Entire go-to-market automation
   - 21-day deployment
   - Target: Scaling SMBs (50-200 employees)

**Cross-sell**: Human VA services at $1,500/mo

## 90-Day Goal

Reach $40,000-$50,000 MRR from 20+ SMB clients (mix of both products).

## How to Deploy This Example

### Step 1: Review the Configuration

`config/company.json` contains all product, pricing, and KPI definitions. All placeholders have been filled with UAIS-specific values.

### Step 2: Review the Agent Prompts

All 9 agent prompts in `agents/` are fully filled-in with:
- UAIS-specific cold email templates
- Vertical-specific pain points (staffing, home services, insurance)
- Product-specific pitch angles
- Proof points and case studies
- Calendly link placeholder (replace {{CALENDAR_LINK}} with your actual link)
- Email domain (usingaitoscale.com)

### Step 3: Configure OpenCode

Create `config/opencode.json` with your OpenRouter API key:

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

### Step 4: Deploy to Paperclip

```bash
bash scripts/deploy.sh
```

This will:
1. Verify Paperclip is running
2. Verify OpenCode is configured
3. Create company goals in Paperclip
4. Print setup instructions

### Step 5: Create the 9 Agents

In Paperclip UI, for each agent (CEO through SDR Warm & Nurture):
1. Create new agent with name from prompt file
2. Set adapter to **OpenCode (local)**
3. Go to **Instructions** tab
4. Copy the full prompt from corresponding `agents/XX_*.md` file
5. Paste into Instructions field
6. Set monthly budget (from company.json budgets section)
7. Set heartbeat (from company.json heartbeats section)
8. Activate agent

## The UAIS 9-Agent Structure

```
BOARD (You / Justin)
    └── CEO (strategy, reporting, $40K-50K MRR goal tracking)
        ├── CMO (cold email sequences, LinkedIn content, brand voice)
        │   └── Social Media Manager (LinkedIn posts, influencer scraping for staffing/home services/insurance)
        ├── COO (client delivery, onboarding, SLA tracking)
        │   └── Operations Specialist (builds OpenClaw agents, 7-day + 21-day deployments)
        └── VP Sales (pipeline management, 3 SDRs, conversion coaching)
            ├── SDR LinkedIn & Social (warm outreach to influencers in verticals)
            ├── SDR Cold Outreach (email/call/text to staffing, home services, insurance leads)
            └── SDR Warm & Nurture (follow-up, re-engagement, conversion tactics)
```

## Key Metrics to Track

| Agent | Monthly Budget | Key Target |
|-------|---|---|
| CEO | $50 | $40K-50K MRR from 20 clients |
| CMO | $30 | 30%+ email open rate on cold sequences |
| COO | $40 | 95%+ on-time delivery rate |
| VP Sales | $40 | 3x pipeline coverage (120-150K pipe for 40-50K goal) |
| Social Media Manager | $25 | 5+ warm leads/week from influencer scraping |
| Operations Specialist | $25 | <7 day average delivery on OpenClaw setups |
| SDR LinkedIn & Social | $25 | 1+ meeting booked/day from warm outreach |
| SDR Cold Outreach | $25 | 2-3 meetings booked/day from cold email/call/text |
| SDR Warm & Nurture | $25 | 20%+ warm-to-SQL conversion rate |

**Total agent cost**: ~$285/month in Paperclip budgets (actual token spend via OpenRouter: $15-50/mo)

## Customization Guide

To adapt this example for your own business:

1. Replace all {{CALENDAR_LINK}} with your actual Calendly/booking link
2. Update company.json with your product names, pricing, verticals, pain points, proof points
3. Update all agent prompts by replacing:
   - {{COMPANY_NAME}} → Your company name
   - {{PAIN_POINT_1}}, etc. → Your actual pain points
   - {{VERTICAL_1}}, etc. → Your target verticals
   - {{PRODUCT_1_NAME}}, etc. → Your product names
   - {{PROOF_POINT}} → Your case study/proof
   - {{EMAIL_DOMAIN}} → Your sending domain

4. Customize cold email sequences in CMO and Cold Outreach SDR prompts to match your product
5. Update product delivery steps in Operations Specialist prompt (Day 1-7 for quick product, Week 1-3 for full system)

## Support

For questions on deploying or customizing this example, refer to the main template README.md one level up.
