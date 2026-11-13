# Operations

Rules and output: [common.md](common.md).

**Surface:** every changed file that decides how the application runs in production – configuration and environment, migrations, calls to external systems, background jobs, error handling and logging, deploy config.

- **Configuration:** a new environment variable, secret or setting that neither has a default nor fails fast at startup with a clear message, or that is missing where the repo declares deploy configuration – example env, deploy manifests, the deploy doc.
- **External calls:** no timeout, a retry on a call that is not idempotent, a failure that reaches the user without a message they can act on.
- **Migrations:** irreversible without saying so; the code still running during the deploy breaks against the new schema – expand/contract; locks or runtime at production data size.
- **Background jobs:** a rerun or two concurrent runs corrupt data; a failure ends where nobody sees it.
- **Diagnosis:** a failure on the new path that does not reach error tracking or the log with enough context to find the cause without asking the user – a swallowed exception, a catch that drops the error.
- **Switch-off:** where the repo has feature flags, new behaviour in a workflow users depend on ships behind one – else `ask:`.
- **Rollback:** redeploying the previous version fails on data the new one wrote.
