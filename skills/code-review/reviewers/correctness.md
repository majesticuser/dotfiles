# Correctness

Rules and output: [common.md](common.md).

**Surface:** every changed file that runs or configures what runs – code, queries, migrations, CI and deploy config.

- **Bugs:** a wrong result, an unhandled case, a broken invariant, a missing await, a wrong query, a race on shared state.
- **Cost at production size:** queries in loops, unbounded loads, per-request work that grows with the data.
- **Intent:** what the intent asks for and the diff does not do, and what the diff does that nobody asked for.
