# AGENTS.md — Agent Architecture & Coordination

## Overview

This system deploys 9 autonomous AI agents on Paperclip, powered by kimi-k2.5 via OpenRouter through OpenCode. Total daily AI cost target: under $5/day.

## Agent Roster

| # | Role | Heartbeat | Daily Token Budget | Scope |
|---|------|-----------|-------------------|-------|
| 01 | CEO | 4h | 5,000 | Strategy, coordination, escalation handling |
| 02 | CMO | 6h | 3,000 | Marketing strategy, content calendar, brand |
| 03 | COO | 4h | 4,000 | Operations, process optimization, delivery |
| 04 | VP Sales | 2h | 4,000 | Pipeline management, deal strategy, pricing |
| 05 | Social Media Manager | 2h | 2,500 | Content creation, posting, engagement |
| 06 | Operations Specialist | 4h | 2,500 | Fulfillment, onboarding, support tickets |
| 07 | SDR LinkedIn Social | 1h | 2,500 | LinkedIn prospecting, connection requests |
| 08 | SDR Cold Outreach | 1h | 2,500 | Cold email campaigns via Instantly.ai |
| 09 | SDR Warm Nurture | 2h | 2,500 | Follow-ups, nurture sequences, re-engagement |

## Coordination Model

```
          ┌─────────┐
          │ 01 CEO  │
          └────┬────┘
     ┌─────────┼─────────┐
     ▼         ▼         ▼
  ┌──────┐ ┌──────┐ ┌──────┐
  │02 CMO│ │03 COO│ │04 VP │
  │      │ │      │ │Sales │
  └──┬───┘ └──┬───┘ └──┬───┘
     ▼        ▼        ▼
  ┌──────┐ ┌──────┐ ┌──────────┐
  │05 SMM│ │06 Ops│ │07 SDR-LI │
  └──────┘ └──────┘ │08 SDR-CO │
                     │09 SDR-WN │
                     └──────────┘
```

## Inter-Agent Dependencies

- **CEO (01)** reads reports from CMO, COO, VP Sales. Sets priorities for all agents.
- **CMO (02)** provides content briefs to Social Media Manager (05). Receives campaign metrics.
- **COO (03)** coordinates with Operations Specialist (06) on delivery and fulfillment.
- **VP Sales (04)** manages all three SDRs (07, 08, 09). Sets outreach quotas and messaging.
- **SDRs (07-09)** feed qualified leads to VP Sales. Must not overlap on the same prospect.

## Agent Prompt Files

All prompts live in `template/agents/` as numbered Markdown files. Example businesses in `examples/` contain customized copies.

### Modification Rules

1. Never modify agent prompts without checking `template/config/company.json` for budget impact.
2. Changes to CEO (01) prompts cascade to all downstream agents -- test coordination flow after changes.
3. SDR prompts (07-09) share prospect deduplication logic. Changes to one must be mirrored to others.
4. Always verify heartbeat intervals stay within OpenRouter rate limits after prompt changes.

## Cost Controls

- Model: `moonshotai/kimi-k2.5` via OpenRouter (cheapest option meeting quality bar)
- Each agent has a daily token budget in `company.json` under `budgets`
- Heartbeat frequency in `company.json` under `heartbeats` controls invocation rate
- SDR agents (1h heartbeat) are the highest-cost agents -- monitor first if costs spike
- Circuit breaker: if any agent exceeds 2x its daily budget, pause and alert CEO agent

## Adding New Agents

1. Create a new numbered prompt file in `template/agents/`
2. Add budget and heartbeat entries to `template/config/company.json`
3. Update `deploy.sh` to include the new agent
4. Update this file with the new agent's role and dependencies
5. Verify total system cost stays under $5/day
