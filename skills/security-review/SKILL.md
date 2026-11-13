---
name: security-review
description: Secure-by-default pass over security-sensitive code — auth, untrusted input, secrets, endpoints, uploads, rendering, dependencies. Use when writing or changing any of those, or when the user asks for a security review or Sicherheitsprüfung. Reviewing a whole diff for bugs and conventions is code-review.
---

The invariants in step 4 hold in every stack. How a repo expresses them is the repo's business, and step 3 is where you find it out — do not carry an idiom over from another project.

## 1. Pin the surfaces

Name which of the headings in step 4 the change touches, and which files put it there. A surface nobody touched is out of scope and stays unmentioned in the report; a surface you cannot rule out is in scope.

Done when every changed file maps to a surface or to none.

## 2. Run what the machine can decide

```bash
mise run audit
```

Unknown task means the repo has not been through the `mise-tasks` skill yet — fall back to what its CI runs, because that is the invocation the project has already agreed on.

These findings are cheap and specific, and a clean run is not the review: dependency scanners see versions, brakeman sees sinks, and neither knows what your domain treats as a privilege.

Done when the scan has run or its absence has a named reason.

## 3. Read this repo's idiom

Before judging any code, establish how this repo already does the thing — a finding that ignores an existing convention is noise. Look for the policy layer, the boundary validation, the templating and what it escapes, where secrets come from, and how the authenticated principal reaches a request. The repo's own CLAUDE.md, AGENTS.md and its existing controllers answer this faster than guessing from the framework.

Then load the reference for what you find. It carries the traps that reading the repo does not reveal:

| Marker in the repo | Reference |
|---|---|
| `bin/rails`, `Gemfile` with `rails` | `references/rails.md` |
| `vite.config.*` with React | `references/react-vite.md` |
| `next` in `package.json` | `references/nextjs.md` |
| `express` outside a browser bundle | `references/node-service.md` |
| `astro.config.*` | `references/astro.md` |
| `go.mod`, `.templ`, htmx | `references/go-htmx.md` |
| `@azure/msal-*`, Entra ID, `jwt` against a tenant | `references/entra-id.md` |

A stack with no reference is not a stack without traps — say so in the report, and work step 4 from the invariants alone.

Done when the repo's idiom for every pinned surface is named, and every matching reference has been read.

## 4. Work each pinned surface

### Secrets

Secrets come from the framework's credential store, the environment, or a secret manager, read at the point of use so a missing one fails at boot rather than in a request. A secret that has ever been committed is burned — rotate it, because deleting it from HEAD leaves it in the history and in every clone.

### Untrusted input

Every value that arrived from outside the process is untrusted, whatever carried it: params, headers, cookies, uploads, webhook bodies, job arguments, third-party responses, imported files. Validate against an allowlist at the boundary, in the shape the domain needs, and pass the validated value onward rather than the raw one.

Uploads additionally bound the size and check extension, declared content type and sniffed type, then store under a generated name outside anything the web server serves directly.

### Queries

Untrusted values reach the database as bound parameters. Interpolation is for values the code itself produced; identifiers arriving from a request come from an allowlist. Every query builder has a raw escape hatch, and that hatch is where injection lives.

### Authorization

Every request loads its records through a scope tied to the authenticated principal, rather than loading by id and checking afterwards. Where a policy layer exists, the scope lives in the policy and the caller asks for it. The proof is a test that a foreign record is refused; without one the rule is untested.

### Sessions and tokens

Rotate the session on sign-in and on every privilege change. Recovery and invite tokens are single-use, expiring and rate-limited. A token that scripts can read is a token XSS can steal. Cookie-based sessions carry CSRF protection; bearer-token APIs replace it with token validation rather than dropping it.

### Rendering

Know which of the repo's rendering paths escapes by default and which does not, then treat every opt-out as security-sensitive code that wants a reason at the call site. Sanitizing means a maintained library with an allowlist of tags, not a blocklist.

### Rate limiting

State-changing and expensive endpoints carry a limit. Sign-in, password reset, invite and search come first.

### What leaves the process

An error reaching a user says that something failed; the backtrace and the values go to the log. Logs carry identifiers, not secrets — parameter filtering covers the framework's own logging and nothing your code writes itself.

### Dependencies

Lockfiles are committed and CI installs from them. A new dependency is weighed on maintenance, transitive weight, native extensions, and whether the framework or stdlib already covers it.

Done when every surface pinned in step 1 has been walked and its outcome named, including the ones that came out clean.

## 5. Report

Order by priority, point at file and line, and separate what is exploitable today from what is hardening.

When this fired while you were writing the code, fix it in place and say what you changed. When the user asked for a review, hand over the findings and let them choose — never apply them yourself unless they ask.

<!-- Invariants adapted from affaan-m/everything-claude-code: skills/security-review and rules/ruby/security.md (MIT). -->
