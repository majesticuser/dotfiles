# PR branch

Rounds of review, triage and fix until only ambiguous and pre-existing items are left. GitHub holds the state, so a rerun picks up where the last one stopped.

## 0. Preconditions

- The PR is open, and its checkout is the current branch – otherwise stop and name `wt switch <branch>`.
- The working tree is clean and rebased onto its remote (`git pull --rebase`).
- **Author:** the PR author is `gh api user`. Otherwise run round 1 up to triage and go to the report – no commit, no push, no GitHub write.

Done when all hold, or the run has stopped with the reason.

## Each round

### 1. Review

Round 1: steps 1–3 of SKILL.md with the PR's base. Later rounds: only if the commits since the last reviewed SHA touch more than docs, and then with that SHA as base.

### 2. Threads

`threads list <pr>`: every unresolved review thread, `human` as soon as a person wrote in it – the PR author included.

### 3. Triage

Every confirmed finding and every thread ends in exactly one bucket, checked in this order. A finding and a thread on the same thing are one item; the thread carries the answer. A finding that matches one from an earlier round is that item, not a new one.

- **Pre-existing** – every finding the verifier labels `pre-existing`, whatever its severity. It stays out of this PR.
- **Actionable** – concrete, localised to one file or a few tightly related edits, no new dependency, no design decision, no change of scope. A thread whose concern the code already resolves counts as fixed.
- **Nit** – style only, speculative, or a duplicate.
- **Ambiguous** – everything else: design and scope calls, several reasonable fixes, findings whose fix is an `ask:`, uncertain findings of severity `high`, and every `human` thread whatever it asks.

Panel findings never go to GitHub.

### 4. Fix

Per actionable item: edit, `git commit --fixup=<sha>` onto the PR commit it corrects, `mise run check`. Red through your edit: fix it, and if that fails, drop the fixup and move the item to ambiguous. Then `git push`, not forced – the rounds need the reviewed SHAs as ancestors.

### 5. Answer the bots

Threads without `human` only:

- **Fixed:** `threads approve <id>`, then `threads resolve <id>`.
- **Nit or not justified:** the reason in one or two sentences via `threads reply <id>`, then `threads resolve <id>`.
- **Ambiguous or pre-existing:** untouched.

A `human` thread gets no reply, no reaction and no resolve.

### 6. CI

`gh pr checks <pr> --watch`, up to ten minutes. Red: `gh run view --log-failed`; caused by your commits → the next round fixes it, otherwise into the report.

### Next round or stop

Next round when this one pushed or a bot thread appeared that you have not triaged. Stop when neither holds, or after round 3.

## Squash

Only if the branch carries `fixup!` commits: `git rebase --autosquash <base>`, then `git push --force-with-lease`. The tree stays the same, so the last round's CI result stands.

Done when no `fixup!` commit is left and `git diff <SHA before> HEAD` is empty.

## Report

- **Ambiguous** first, the part I decide: `file:line` or thread URL, the question in one line, the fix you would make; for a `human` thread also a reply draft in the thread's language, which I send.
- **Pre-existing** next, as step 4 of SKILL.md lists them.
- One line per round: head SHA, findings confirmed, pre-existing and refuted, fixups pushed, bot threads approved and answered, CI result.
- The squash: SHA before and after, commits left on the PR.
- One line per nit and per refuted finding, with the reason.
- Tokens and duration per agent, summed per round.

Done when the counts reconcile: every finding and every thread sits in exactly one bucket.
