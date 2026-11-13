# Go with templ and htmx

## Traps

- **`text/template` escapes nothing.** Only `html/template` is contextually auto-escaping, and the import line is the entire difference. templ escapes by default; `templ.Raw` opts out.
- An `href` built from a plain string accepts `javascript:`. `templ.URL` is what sanitizes the scheme, and `templ.Attributes` from user data injects attributes.
- htmx swaps server HTML straight into the live DOM, so a fragment is a rendering surface with the same weight as a full page — an escaping gap in a partial executes.
- `hx-vals` and `hx-headers` evaluate JavaScript when the value carries the `js:` prefix.
- `HX-Redirect` and `HX-Location` built from user input are open redirects that never touch a URL bar.
- `db.Query(fmt.Sprintf(...))` compiles as readily as the placeholder form. Placeholders are per-driver: `$1` for pgx, `?` for MySQL and SQLite.
- `filepath.Join` happily resolves `..` out of the directory you meant. `os.Root` (Go 1.24+) confines it; validation before joining is the alternative.
- `http.Error(w, err.Error(), 500)` sends the internal error text to the client.
