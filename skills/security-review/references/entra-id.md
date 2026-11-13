# Entra ID and MSAL

The client's token proves nothing. Whatever the SPA or the CLI acquired, the server validates independently: signature against the tenant's JWKS, then `aud`, `iss`, `exp` and — for a single-tenant app — `tid`. A token that is valid for a different audience is a valid token.

## Traps

- **Group claims are omitted past the overage limit** and replaced by an indicator pointing at Graph. Authorization keyed on group membership therefore works for small accounts and changes behaviour for large ones, in whichever direction the code's default happens to be. App roles do not have this problem.
- `roles` and `scp` are different claims: app roles from client-credentials flows, delegated scopes from user flows. Checking one and granting what the other implies hands app-level reach to a user token.
- A client-credentials token has no user, so `oid` and `preferred_username` are absent. Code that derives a principal from those claims must refuse the token rather than fall through to an empty principal.
- Client secrets expire on a date nobody has in a calendar; certificate credentials avoid the outage and the rotation.
- MSAL browser caches tokens where the configured `cacheLocation` says. That location is the blast radius of any XSS in the app.
