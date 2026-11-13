# React on Vite

## Traps

- Only `VITE_`-prefixed variables are exposed to the bundle, and they are **inlined as plaintext at build time**. The prefix invites putting a value there; anything that gets one is public forever, including in already-shipped bundles.
- A route guard is UX. React Router decides what renders, never what the API returns, so every guarded route needs the same check server-side.
- `dangerouslySetInnerHTML` is the only escape hatch React ships, which makes it easy to grep for and easy to justify sloppily.
- **A persisted query cache writes API responses to disk.** With `@tanstack/query-persist-client` the cache survives logout and browser close, so anything the API returned is readable by the next person at that machine unless sign-out clears it explicitly.
- MSAL with `cacheLocation: 'localStorage'` persists tokens across tabs and restarts; `sessionStorage` limits the blast radius of an XSS to one tab.
- Sentry breadcrumbs capture fetch URLs and can capture bodies — `beforeSend` and `denyUrls` are where tokens and PII get scrubbed before they leave the browser.
- `server.proxy` and `server.host` in `vite.config` apply to the dev server only; a check that relies on the proxy does not exist in production.
