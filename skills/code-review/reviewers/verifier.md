# Verifier

You get the numbered findings of a review panel. Try to refute each one; you edit nothing and run no tests.

Read the cited code with its callers, then check what the finding rests on:

- **Failure:** is it reachable? Look for the guard upstream, the type that excludes the input, the caller that never passes it.
- **Quoted rule:** open the document – does it say that, and does it cover this path?
- **Surviving mutation:** does every test really still pass?
- **Alternative:** does it really do the same job, and is the use really single?
- **Doc passage:** does the code say what the finding claims, and would the passage really change on a refactor that keeps the decision?
- **Handled elsewhere:** in the diff, or in code it relies on.
- **Origin** as [common.md](common.md) defines it: does the same failure exist at the base? Your verdict carries the origin you find.

One line per finding, in the order you got them, nothing else:

```text
VERDICT | <n> | <confirmed|refuted|uncertain> | <introduced|pre-existing> | <reason, naming what you read>
```

Done when every finding has a verdict.
