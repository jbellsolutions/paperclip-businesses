# CLAUDE.md — Operational Rules

These rules govern ALL agent behavior in this workspace. They are non-negotiable.

---

## Core Behavior

1. If you can do it yourself, do it. Never ask the user to do manual work. Once approved, handle everything.
2. Own the full task. Do not ask permission at every sub-step.
3. When told "DO NOT" touch something, do not touch it. During brainstorms, always confirm before executing.
4. When stuck, say so immediately. Do not spin.
5. If you see a security risk, flag it immediately even if not asked.
6. Check if edits could affect other sessions before making them.
7. Never force-close browsers or install programs without approval.
8. The user may call you "AG."

## Verification (Non-Negotiable)

9. Every build/fix MUST be tested as hard pass/fail. No untested work ships.
10. Never claim "fixed" without hard visual proof or concrete data.
11. When asked if something is "ready" — run a full end-to-end audit. Return HARD PASS or HARD FAIL with a plain-English verdict.
12. Run live tests immediately after building or modifying pipelines.
13. Anti-Hallucination Protocol: Before claiming any status — identify the proof command, run it fresh, read full output, verify. Words like "should", "probably", "seems to" are red flags — stop and verify.
14. Debugging Protocol: No fixes without root cause investigation. Phase 1: reproduce. Phase 2: compare working vs broken. Phase 3: single hypothesis, smallest change. Phase 4: implement only after verifying root cause.
15. Plans must be bite-sized with intermediate verification points.

## Security

16. No unauthorized live tests on cron jobs or triggers. Get permission first.
17. Lock assets into state files before publishing. No guessing, no fallbacks.
18. NEVER delete production assets without explicit approval.
19. Default to OAuth/Google sign-in for new accounts.
20. Use --dry-run before wiring scripts into schedulers. --force required for destructive actions.
21. Files depended on by 2+ scripts get 3-layer protection: guard header, protected registry, graceful degradation.
22. Plugin installs go through the security scanner. Direct installs are forbidden.

## Architecture

23. Modify config files directly. Do not search internal databases.
24. Check for current AI models online. Do not rely on memory.
25. Every pipeline that generates temp files MUST have cleanup built alongside it.
26. Fix root causes first. Lazy fixes (timeouts, retries) only after root cause is resolved.
27. Every pipeline needs two layers: (1) Preflight health check, (2) Self-healing auto-fix loop.
28. Check if a task can use raw Python/Bash before spending LLM tokens.
29. Flag overlapping systems immediately for merge review.
30. Production pipelines need error classification (FATAL vs RETRYABLE), cooldown retries, circuit breakers, and self-healing.
31. When replacing code/configs, delete the old version in the same pass. No orphans.
32. NEVER hardcode timezones. Read from config dynamically.

## Content & Publishing

33. Never post the same content twice. Verify via live screenshot.
34. No "test post" language on public platforms.
35. Short-form writing: no "Wh-" starters, no dramatic fragments, no rhetorical setups, no meta-commentary.

## Honesty

36. Never fabricate data. "I don't know" beats a wrong confident answer.
37. Cite sources for factual claims. No source = "this is my assumption."
38. Reason independently when asked for opinions. Never agree out of compliance.
39. No performative agreement in code reviews. Technical correctness over social comfort.
40. Present design before writing code. Every project.

## Documentation

41. Auto-log every error fix: date, issue, what didn't work, final fix.
42. Track time: daily memory with work type (BUILD, BUGFIX, DEBUG, AUDIT, RESEARCH).
43. Wire notifications into feedback loops.
44. "Audit" = report only. Execute only on explicit approval.
45. Long-term memory = permanent knowledge only. Daily stuff goes in daily files.
46. Log crash patterns. Read them before writing new scheduled scripts.
47. Sync rules to all instances when modified.

## Business

48. No building before payment confirmation on client work.
49. Auto-update contract templates during deal sessions.

## Cost

50. Optimize token spend. Use standard scripts when LLMs are not needed. Functionality first.

## Research

51. Search online for best practices before building anything non-trivial.

## API

52. The OAuth token works. Never suggest generating a new key. If a call fails, fix HOW the call is made.

---

## Session Startup Checklist

Every new session MUST begin with these steps in order:

1. Read this file (`CLAUDE.md`) fully.
2. Read `AGENTS.md` for agent architecture and inter-agent dependencies.
3. Check `.claude/healing/history.json` for recent errors and active patterns.
4. Check `.claude/learning/observations.json` for accumulated project knowledge.
5. Check `claude-progress.txt` for incomplete work from prior sessions.
6. Run `git status` and `git log --oneline -5` to understand current state.
7. If modifying agent prompts or configs, read `template/config/company.json` for budget constraints.

## Session End Instructions

Before ending ANY session:

1. Update `claude-progress.txt` with: what was done, what is pending, blockers found.
2. Log any new error patterns to `.claude/healing/history.json`.
3. Log any new project insights to `.claude/learning/observations.json`.
4. If agent prompts were modified, verify total daily cost stays under $5/day target.
5. Run `git status` to confirm no uncommitted work is left untracked.

## Compaction Rules

When context is running low or a compaction is triggered:

1. PRESERVE: Current task description, file paths being edited, error messages being debugged, git branch state.
2. PRESERVE: Any cost calculations in progress (agent budgets, API spend estimates).
3. SUMMARIZE: Research findings into bullet points.
4. DROP: File contents already committed. Re-read from disk if needed.
5. DROP: Shell output from successful commands (keep only failures).
6. ALWAYS re-read `claude-progress.txt` after compaction to restore context.

## Search Strategy

When looking for information in this repo:

1. Agent prompts: `template/agents/` (numbered 01-09), check `examples/` for customized versions.
2. Configuration: `template/config/company.json` (budgets, heartbeats, model settings).
3. Deployment: `template/scripts/deploy.sh` and `examples/*/deploy.sh`.
4. Infrastructure patterns: `infrastructure/templates/` (self-healing, security layers).
5. Business rules: `rules/RULES.md`.
6. Cost data: `template/config/company.json` under `budgets` and `heartbeats` keys.

## Thinking Guidelines

Before modifying agent prompts, deployment configs, or adding new automation:

1. **Cost check**: Will this change increase API token usage? Each agent has a daily token budget in `company.json`. The total system MUST stay under $5/day in AI costs (kimi-k2.5 via OpenRouter).
2. **Rate limits**: OpenRouter enforces per-minute and per-day rate limits. Agents with 1h heartbeats (SDRs) are the most rate-limit-sensitive. Never reduce heartbeat intervals without calculating the rate limit impact.
3. **Cascade effects**: Agent 01 (CEO) coordinates all others. Changes to CEO prompts ripple to all 8 downstream agents. Changes to config schemas affect `deploy.sh` and all example businesses.
4. **Credential safety**: Never hardcode API keys, OpenRouter tokens, or email credentials in agent prompts or config files. Use environment variables or Paperclip's secret management.
5. **Rollback plan**: Before making multi-file changes, note the current git state. If changes break the under-$5/day target, revert immediately.
