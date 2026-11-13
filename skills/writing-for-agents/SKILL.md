---
name: writing-for-agents
description: Write or revise a document an agent reads — a skill, CLAUDE.md, AGENTS.md, or a doc reached by a pointer. Use when creating or editing any of them.
---

# Writing for agents

An agent document is judged on one thing: does the agent take the same **process** every run? Same output is not the goal — same process is.

Work the six passes below in order. **Done when every pass has been applied, and for each you can name what it changed in the document or why it did not apply.**

## 1. Pointer

The **pointer** is what triggers the material: a skill's `description`, a line in `CLAUDE.md` naming a doc. Its wording — not its target — decides whether the agent reaches it.

- Front-load the triggering word.
- One trigger per **branch** the document handles. Synonyms are one branch written twice; collapse them.
- Cut identity the body already carries.

A weak pointer to must-have material is a variance bug. Sharpen the wording first; inline the material only if sharpening fails.

## 2. Invocation

- **Model-invoked** (omit `disable-model-invocation`) — the agent fires it on its own, and other skills can reach it. Its description sits in context on **every** turn, so the trigger phrasing must earn that rent.
- **User-invoked** (`disable-model-invocation: true`) — only reachable by typing its name. Zero context cost, paid for by having to remember it exists; the description becomes a one-line summary for a human, trigger phrasing stripped.

Choose model-invoked only when the agent must reach it unprompted.

## 3. Hierarchy

Place every piece on the ladder: **steps** the agent performs, in order → **in-file reference** consulted on demand → **disclosed reference** in a separate file behind a pointer.

Cut by branch: inline what every branch needs, disclose what only some branches reach. Keep a concept's definition, rules and caveats under one heading, so reading one part brings its neighbours along.

## 4. Completion criteria

Every step ends on a condition that says done. Make it **checkable** — can the agent tell done from not-done? — and **demanding**: "every modified model accounted for" forces work that "produce a change list" does not. A document that is pure reference still carries a bar: "every rule applied".

A vague bound invites finishing early, with the steps still ahead pulling attention. Sharpen the wording first; split the sequence only if the bound stays fuzzy and you watch the agent rush.

## 5. Words

Steer with words the model already knows — *seam*, *tracer bullet*, *tight loop*, *red*. Repeat the word as a token and let the definition accumulate; it anchors a whole region of behaviour in few tokens because the priors are already there. Coining your own costs definition tokens that a pretrained word gives free, so reach for the existing word first.

State the target behaviour rather than the ban: a prohibition drags the forbidden behaviour into context and makes it more available. "Write one-line comments" beats "don't write verbose comments".

## 6. Prune

- **No-ops** — delete whole sentences the model already obeys by default. Settle disagreements by running the document, not by arguing about them.
- **Duplication** — one meaning, one place, so changing the behaviour is a one-place edit.
- **Environment** — `package.json` scripts, config files, `--help` are already sources of truth, and a document restating them goes stale. Capture only what the agent cannot look up: the unwritten convention, the reason behind a choice, the gotcha.
- **Relevance** — cut lines that no longer bear on what the document does, before they settle into layers nobody dares remove.

<!-- Levers distilled from mattpocock/skills `writing-for-agents` (MIT). -->
