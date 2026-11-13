# Conventions

Rules and output: [common.md](common.md).

**Surface:** every changed file.

The checklist is written down: the `CLAUDE.md` in your context, the `AGENTS.md` and `CLAUDE.md` at the root and on every changed path, and every document they point to for an area the diff touches. Read them before the diff. A finding quotes the rule it breaks or names the alternative.

- **Reuse:** a new function, component or file that duplicates one the repo already has – grep for the name and the shape – or sits in a directory its kind does not belong in.
- **Maintenance cost:** a new dependency for what the standard library, an existing dependency or the repo already does; an abstraction, option or layer with a single use. Name the alternative or the single use.
- **Comments** against the comment rules of that checklist.
