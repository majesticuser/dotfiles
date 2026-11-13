# Astro

## Traps

- In a static build **everything is evaluated at build time and baked into the output**, so the `PUBLIC_` prefix is not the boundary it looks like. A non-prefixed variable read in a component that renders to static HTML ends up in the artifact.
- `set:html` is the escape hatch; content collections built from remote or authored Markdown reach it most often.
- `Astro.request` headers and cookies are empty in static output, so a check written against them silently passes.
- The security surface of a marketing site is its forms, its endpoints and its build: a compromised build-time dependency writes directly into what visitors download.
