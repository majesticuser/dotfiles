---
name: code-review
description: Panel review – the local diff as a report, or a GitHub PR (number or URL) fixed and triaged until only your calls are left.
argument-hint: "[PR number or URL]"
disable-model-invocation: true
allowed-tools: Bash(${CLAUDE_SKILL_DIR}/threads *)
---

Six reviewers work the same diff in parallel, one focus each; a verifier then tries to refute what they found. Only what survives reaches the report.

- **No argument → local branch:** steps 1–4.
- **PR number or URL → PR branch:** follow `${CLAUDE_SKILL_DIR}/pr.md`. Every GitHub read and write on review threads goes through `${CLAUDE_SKILL_DIR}/threads` (`--help` for the commands).

Argument: $ARGUMENTS

## 1. Pin the diff

Base is the merge-base with the default branch, or the base the PR branch hands you. Review `<base>...HEAD`, plus uncommitted work when there is any – say that you included it. Intent comes from `git log <base>..HEAD`, the PR title and body, and the issue they name.

Done when the base resolves, the diff is non-empty, and you hold the file list, the HEAD SHA and the intent.

## 2. Run the scan

`mise run audit`, once. Unknown task: the audit step the repo's CI runs. Its output goes to the security reviewer.

Done when the scan has run or its absence has a named reason.

## 3. Panel

Spawn the six reviewers in **one message, in the foreground**, each a `general-purpose` agent with `model: opus`. Each prompt: "Follow `${CLAUDE_SKILL_DIR}/reviewers/<focus>.md`", then base, HEAD SHA, file list and intent; the security prompt also carries the scan output and `${CLAUDE_SKILL_DIR}/../security-review/SKILL.md`, the docs prompt `${CLAUDE_SKILL_DIR}/../writing-for-agents/SKILL.md`.

Focus: `correctness`, `operations`, `conventions`, `tests`, `security`, `docs`.

Merge what they return: the same file within about five lines, or the same root cause, is one finding – keep the highest severity, `introduced` over `pre-existing`, and name every focus that found it. Then spawn one verifier the same way with "Follow `${CLAUDE_SKILL_DIR}/reviewers/verifier.md`" and the merged list, numbered.

Done when every reviewer has returned – `not touched` counts – and every merged finding carries a verdict.

## 4. Report

Findings are the confirmed ones plus uncertain ones of severity `high` marked as uncertain, highest severity first, split by the verifier's origin:

- **Introduced:** `file:line`, the failure or the rule, the fix – an `ask:` as a question to me.
- **Pre-existing**, for us to discuss: `file:line`, the failure and whom it hits, and a ticket draft – title, impact, location, proposed fix – which I file. Name the ones the customer should hear about: data already wrong, an exploitable hole.
- One line per refuted or uncertain `medium`/`low` finding, with the verifier's reason.
- One line per reviewer: its coverage, tokens and duration.

Hand the findings over and apply nothing unless I ask.

Done when every merged finding appears in the report exactly once.
