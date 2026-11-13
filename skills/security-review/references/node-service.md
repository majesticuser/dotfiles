# Node services (Express, CLI, headless browser)

## Traps

- **`yup.validate()` keeps unknown keys.** Validation passes and the extra fields travel onward, so mass assignment survives a schema that looks complete. `stripUnknown: true` is what makes validation a boundary. `validateSync` throws rather than resolving.
- `cors()` with no arguments allows every origin. Reflecting the request origin back alongside `credentials: true` is the same mistake with more steps.
- Express' default error handler prints stack traces whenever `NODE_ENV` is not `production` — and an unset `NODE_ENV` in a container counts as not production.
- `express.json()` caps bodies at 100kb; anything that raises the limit for one route raises the memory a single request can claim.
- Parameterize per driver: `mssql` via `request.input(...)`, `pg` via `$1` placeholders. Neither is the default when a template literal is at hand.
- Nodemailer with a user-controlled recipient is an open relay, and user-controlled header values are header injection.
- A `prom-client` `/metrics` endpoint publishes route names, timings and internals to whoever asks.

## Headless browser

Navigating Puppeteer to a URL a user supplied is SSRF with a rendering engine attached — it reaches link-local metadata endpoints and anything else the container can route to. `--no-sandbox` removes the process isolation that makes rendering untrusted pages survivable, and the stealth plugins change fingerprints, not privileges.
