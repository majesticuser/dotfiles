# Tests

Rules and output: [common.md](common.md).

**Surface:** changed tests, and changed code whose behaviour a test should pin.

The repo's test strategy comes first – `docs/test-strategie.md`, or what `AGENTS.md` names. Then, for every new or changed test:

1. **Name against assertion** – the assertion proves what the name claims.
2. **Surviving mutation** – a concrete change to the code under test that every test still passes. The mutation is the finding.
3. **Result, not absence of error** – each case asserts a status, body or state.
4. **Negative twin** – every condition has a case where it does not hold.
5. **Duplicates** – same setup, same assertion target.
6. **Coverage** – every acceptance criterion in the intent has a test; new behaviour is covered as far as it reaches: happy path, validation, authorization, empty state, error handling, the domain's edge cases.
7. **Anti-patterns** – assertions on internals, a test of the mock, an `if` in a test, timing or random data.
