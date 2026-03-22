# Paperclip Autonomous Businesses

Deploy a fully autonomous AI-powered business on [Paperclip](https://paperclip.ing) in minutes. Each business runs 9 AI agents on OpenCode + kimi-k2.5 via OpenRouter — prospecting, selling, marketing, and delivering — for under $5/day in AI costs.

## How It Works

1. Pick a business model from `examples/`
2. Run the deploy script
3. Paste agent instructions into Paperclip
4. Activate agents — the business runs itself

You check the dashboard. You take demo calls. The agents handle everything else.

## Repo Structure

```
paperclip-businesses/
├── README.md                    # You are here
├── template/                    # Reusable template for any business
│   ├── TEMPLATE.md              # How to create your own business
│   ├── config/
│   │   ├── company.json         # Company config template
│   │   ├── opencode.json        # OpenCode + OpenRouter config
│   │   └── heartbeats.json      # Agent heartbeat schedule
│   ├── agents/
│   │   ├── 01_ceo.md
│   │   ├── 02_cmo.md
│   │   ├── 03_coo.md
│   │   ├── 04_vp_sales.md
│   │   ├── 05_social_media_manager.md
│   │   ├── 06_operations_specialist.md
│   │   ├── 07_sdr_linkedin_social.md
│   │   ├── 08_sdr_cold_outreach.md
│   │   └── 09_sdr_warm_nurture.md
│   └── scripts/
│       └── deploy.sh            # Automated setup script
│
├── examples/
│   ├── uais-openclaw-agency/    # Example 1: Sell OpenClaw + Autonomous Business
│   │   ├── README.md
│   │   ├── config/
│   │   │   └── company.json
│   │   └── agents/              # 9 agent prompts customized for this business
│   │
│   └── ai-gtm-agency/          # Example 2: AI Go-To-Market Agency
│       ├── README.md
│       ├── config/
│       │   └── company.json
│       └── agents/              # 9 agent prompts customized for this business
```

## Prerequisites

- [Paperclip](https://paperclip.ing) running (`npx paperclipai onboard --yes`)
- [OpenCode](https://opencode.ai) installed (`npm install -g @anthropic/opencode`)
- [OpenRouter](https://openrouter.ai) API key (for kimi-k2.5 model)
- A calendar booking link (Calendly, Cal.com, etc.)
- Email sending tool (Instantly.ai recommended)

## Quick Deploy

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/paperclip-businesses.git
cd paperclip-businesses

# Deploy an example business
bash examples/uais-openclaw-agency/deploy.sh

# Or deploy the AI GTM agency
bash examples/ai-gtm-agency/deploy.sh
```

## Cost to Run

| Component | Monthly Cost |
|-----------|-------------|
| 9 agents via OpenRouter (kimi-k2.5) | $15-50 |
| VPS (optional, for 24/7) | $24 |
| Instantly.ai (cold email) | $30-97 |
| Phone/SMS | $15-25 |
| OpenRouter API credits | $20-50 |
| **Total** | **$104-246/mo** |

One client covers the entire operating cost.

## Available Business Models

### Example 1: UAIS OpenClaw Agency
Sells two products to SMBs:
- **Product 1**: OpenClaw Agent Setup ($0 upfront, 7-day trial, $2K-$2.5K/mo)
- **Product 2**: Autonomous Business System ($5K-$10K setup + $3K-$5K/mo upsell)

### Example 2: AI Go-To-Market Agency
Sells AI-powered go-to-market services:
- **Product 1**: AI GTM Sprint ($2,500 one-time, 14-day delivery)
- **Product 2**: Managed AI GTM Retainer ($3K-$5K/mo ongoing)

## Create Your Own

See `template/TEMPLATE.md` for a step-by-step guide to creating your own autonomous business model.

## License

MIT
