# GEMINI.md — Instructions for Gemini-based AI Assistants

## Project Context

This is an autonomous AI business deployment system for Paperclip. It contains shell scripts, JSON configs, and Markdown agent prompts for deploying 9 AI agents (CEO, CMO, COO, VP Sales, Social Media Manager, Operations Specialist, and 3 SDRs) that run a business autonomously.

## Key Constraints

- **Cost target**: Total AI costs must stay under $5/day across all 9 agents
- **Model**: kimi-k2.5 via OpenRouter (do not suggest switching models without cost analysis)
- **Platform**: Paperclip (paperclip.ing) with OpenCode as the agent runtime
- **No hardcoded secrets**: API keys, tokens, and credentials must use environment variables

## File Map

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Primary AI assistant rules (52 rules + session management) |
| `AGENTS.md` | Agent architecture, coordination model, cost controls |
| `template/agents/01-09_*.md` | Agent prompt templates (numbered by role) |
| `template/config/company.json` | Company config: products, budgets, heartbeats, model settings |
| `template/config/opencode.json` | OpenCode runtime configuration |
| `template/scripts/deploy.sh` | Automated deployment script |
| `examples/` | Pre-built business models with customized agent prompts |
| `infrastructure/` | Self-healing pipeline and security layer templates |
| `rules/RULES.md` | Business rules and operational constraints |

## What You Can Help With

1. **Agent prompt optimization** -- improve clarity, reduce token usage, maintain behavior
2. **Config validation** -- check company.json for completeness and consistency
3. **Deploy script improvements** -- error handling, preflight checks, rollback support
4. **New business models** -- create new examples following the template pattern
5. **Cost analysis** -- estimate token usage per agent based on heartbeat frequency

## What to Avoid

1. Do not modify `CLAUDE.md` without understanding all 52 rules
2. Do not change heartbeat intervals without calculating rate limit impact
3. Do not add agents without updating `AGENTS.md` and verifying cost target
4. Do not hardcode any credentials in any file
5. Do not suggest model changes without a cost comparison table

## Testing Changes

- Agent prompt changes: dry-run with `deploy.sh --dry-run` before activating
- Config changes: validate JSON with `python3 -m json.tool template/config/company.json`
- Cost impact: multiply (tokens_per_invocation * invocations_per_day * cost_per_token) for each agent
