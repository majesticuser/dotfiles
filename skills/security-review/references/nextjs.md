# Next.js

## Traps

- **Every Server Action is a public POST endpoint.** Being a function that only a form calls is not access control: it re-authenticates and re-authorizes on entry, and treats its arguments as untrusted, exactly like a route handler.
- `NEXT_PUBLIC_` inlines the value into the client bundle at build time. Same shape as Vite's prefix, same permanence.
- The `"use client"` boundary is per module graph, not per line. Importing a module that reads a secret into a client component ships the secret.
- Route handlers have no CSRF protection and no origin check — the Server Action origin check does not extend to them.
- Middleware is a convenience layer, not an authorization boundary: matchers have gaps, and CVE-2025-29927 was a header that skipped it entirely. Authorization that exists only in `middleware.ts` is one bypass from absent.
- `images.remotePatterns` with a broad wildcard turns the image optimizer into a fetcher for arbitrary URLs.

## Prisma

- `$queryRaw` with a template literal parameterizes; `$queryRawUnsafe` and `$executeRawUnsafe` do not, and the names are the only warning.
- Prisma has no row-level security. Scoping every query to the authenticated principal is entirely the application's job.
- A model returned whole returns everything on it — password hashes, tokens, internal flags. `select` and `omit` are what keep them server-side.
