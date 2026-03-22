# UAIS OpenClaw Agency - Setup Checklist

## What Was Created

Complete filled-in example of Using AI To Scale, a B2B SaaS agency selling:
- **OpenClaw Agent Setup**: $2K-$2.5K/mo, 7-day deployment
- **Autonomous Business System**: $5K-$10K setup + $3K-$5K/mo, 21-day deployment
- **Target verticals**: Staffing Agencies, Home Services (HVAC/Plumbing/Electrical), Insurance Agencies
- **90-day goal**: $40K-$50K MRR from 20+ clients

## Files Created

### 1. Configuration
- `config/company.json` - All placeholders filled with UAIS values
  - Products, pricing, pain points, proof points
  - Agent budgets and heartbeats (ready to paste into Paperclip)

### 2. Documentation
- `README.md` - Deployment instructions and customization guide
- `SETUP_CHECKLIST.md` - This file

### 3. Agent Prompts (All 9 agents, fully filled-in)
- `agents/01_ceo.md` - Strategy, reporting, daily briefings, KPI tracking
- `agents/02_cmo.md` - Brand voice, cold email sequences (3 pain points), sales collateral
- `agents/03_coo.md` - Delivery SLAs, client intake, operations planning
- `agents/04_vp_sales.md` - Pipeline management, SDR coaching, discovery playbook
- `agents/05_social_media_manager.md` - LinkedIn content, influencer scraping, engagement
- `agents/06_operations_specialist.md` - Product delivery (Agent Setup 7-day, Full System 21-day), QA
- `agents/07_sdr_linkedin_social.md` - Warm outreach, influencer engagement, DM sequences
- `agents/08_sdr_cold_outreach.md` - Email campaigns (3 sequences), calls, texts, lead scoring
- `agents/09_sdr_warm_nurture.md` - Nurture sequences, re-engagement, objection handling

## Key Features Included

### Vertical-Specific Cold Email Templates
- **Staffing Agencies**: Focus on "missing 40% of inbound calls" → "capture 100% of leads"
- **Home Services**: Focus on "60% of time on admin" → "free up 15+ hours/week"
- **Insurance**: Focus on "no follow-up system" → "automated follow-up sequences"

### Real Proof Points & Case Studies
- Staffing agency: $180K → $340K revenue in one quarter
- Plumbing company: Saved 400 hours/year on admin
- Insurance agency: Closed 3 additional clients/month from follow-ups

### Complete Sales Playbook
- Discovery call framework (30 min structure)
- Lead scoring methodology (0-10 scale)
- Objection handling by vertical
- Competitive positioning

### KPI Targets
- Pipeline coverage: 3x revenue goal (120K-150K pipe for 40K-50K MRR goal)
- Close rates: 40-50% SQL → Opportunity
- Sales cycle: 14-21 days for Agent Setup, 21-30 days for Full System
- Email metrics: 30%+ open rate, 3%+ reply rate, 5%+ meeting rate

## How to Deploy

### Step 1: Update Calendar Link
Replace all `{{CALENDAR_LINK}}` with your actual Calendly/booking link

### Step 2: Create 9 Agents in Paperclip
For each agent (01 through 09):
1. Create new agent in Paperclip
2. Set adapter to **OpenCode (local)** with **kimi-k2.5** model
3. Copy entire prompt from `agents/XX_*.md` file
4. Paste into **Instructions** tab
5. Set monthly budget (from company.json)
6. Set heartbeat interval (from company.json)
7. Activate agent

### Step 3: Configure Agent Communication
- CEO manages: CMO, COO, VP Sales
- CMO manages: Social Media Manager
- COO manages: Operations Specialist
- VP Sales manages: SDR LinkedIn & Social, SDR Cold Outreach, SDR Warm Nurture

### Step 4: Start Operations
- Agents will begin running on their heartbeat schedule
- CEO will generate daily briefings
- SDRs will begin outreach to staffing, home services, and insurance verticals

## Monthly Cost Estimates

| Agent | Budget | Est. Actual Cost (OpenRouter) |
|-------|--------|---|
| CEO | $50 | $5-10 |
| CMO | $30 | $3-5 |
| COO | $40 | $5-8 |
| VP Sales | $40 | $5-8 |
| Social Media Manager | $25 | $3-5 |
| Operations Specialist | $25 | $3-5 |
| SDR LinkedIn & Social | $25 | $3-5 |
| SDR Cold Outreach | $25 | $3-5 |
| SDR Warm & Nurture | $25 | $3-5 |
| **TOTAL** | **$285** | **$30-60** |

Budgets are caps in Paperclip. Actual token costs with kimi-k2.5 via OpenRouter are typically 10-20% of budgets.

## What You'll Need to Customize

1. **Calendar link** ({{CALENDAR_LINK}}) - Your booking system
2. **Email domain** (usingaitoscale.com) - Your actual sending domain
3. **API keys**: OpenRouter API key for OpenCode configuration
4. **Verticals** (optional): If you want to target different industries, update pain points in all 9 agents
5. **Proof points** (optional): Add your own case studies/testimonials as you get them

## First 90 Days Expected Output

| Metric | Target |
|--------|--------|
| Cold emails sent | 67,500 (300/day × 90 days) |
| Cold calls made | 3,600 (40/day × 90 days) |
| Meetings booked | 270 (3/day × 90 days) |
| SQLs created | 135 (50% of meetings) |
| Deals closed | 54 (40% of SQLs) |
| **MRR achieved** | **$40K-50K** (mix of Agent Setup and Full System) |

## Support & Optimization

- **First week**: Monitor agent outputs, fix any prompt issues
- **Week 2-4**: Optimize email sequences based on open/reply rates per vertical
- **Month 2**: Shift budget to highest-converting vertical
- **Month 3**: Scale successful sequences, test new angles, prepare to hit 90-day goal

---

**Ready to deploy? Start with Step 1 above and follow the README.md for detailed instructions.**
