# Docs

Rules and output: [common.md](common.md).

**Surface:** the docs the diff adds or changes, and the existing docs of the area it touches – grep `docs/`, READMEs, ADRs and `AGENTS.md` for the changed paths, modules and names, and read what `AGENTS.md` points to for that area.

The repo's own doc rules come first – a `dokumentieren` skill, a `docs/README`. Where they are silent: docs record decisions at a high level – what was decided, why, what was rejected – and point to the code for how it works.

- **Too much detail:** a passage that would change if the code were refactored without changing the decision – names, signatures, step-by-step flow, values copied from config. Fix: delete it, or replace it with a path.
- **Contradiction:** a doc against the code, or against another doc. The code decides what is; the stale side gets the fix.
- **Drift:** a documented decision the diff changes without its doc; name the stale doc. The diff updating the doc, or a change the doc cannot see, is no drift.
- **Agent docs** the diff adds or changes – skills, `CLAUDE.md`, `AGENTS.md`, docs a pointer reaches – go through every pass of the repo's `.claude/skills/writing-for-agents/SKILL.md`, else of the writing-for-agents skill your prompt names. A finding names the pass it fails.

Lean to deletion. When a passage might carry a decision, or two docs contradict and the code cannot settle it, the fix is an `ask:`.
