# Rails

Two profiles behave differently and the difference decides half the review: an **API-only** app authenticating bearer tokens has no session cookie and therefore no CSRF story to keep, while a **full-stack** app has both. Establish which one you are in before reading further.

## Traps

- `params.permit!` and `params.to_unsafe_h` switch strong parameters off while looking like ordinary API. Same for a `permit` list that ends in a hash of unbounded keys.
- With Pundit, `authorize` on a collection action authorizes nothing about the collection — `policy_scope` is what scopes it. `verify_authorized` and `verify_policy_scoped` as `after_action` are what stop the omission from being silent.
- `order` and `pluck` reject raw SQL since Rails 6.1, so the residual risk is `Arel.sql(params[...])`, which opts back out.
- `link_to` escapes the label, not the scheme: a user-controlled href can be `javascript:`.
- Engines mounted in `routes.rb` — Sidekiq Web, Flipper UI, rswag UI, PgHero — are unauthenticated admin surfaces unless wrapped in a `constraints` block or `authenticate`.
- Sidekiq job arguments are untrusted whenever a request put them there, and they are readable in the queue as plaintext.
- PaperTrail versions keep the old values of attributes that were later scrubbed, which makes the versions table a PII store of its own.
- Active Storage direct uploads reach the bucket without passing your controller, so content and size checks belong on the attach, not on the form.
- `rack-cors` with `origins '*'` alongside `credentials: true` is the combination browsers reject and servers still misconfigure.
- The `jwt` gem verifies nothing when passed `nil, false`, and an `algorithm:` allowlist is what prevents algorithm confusion.

## Where things live

Credentials in `config/credentials/*.yml.enc`, and for Kamal deployments in `.kamal/secrets` — which reads from the environment and is not itself a place to put a secret. `config.filter_parameters` covers Rails' own request logging.
