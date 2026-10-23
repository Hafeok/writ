# Writ

Governed decisions for agent-written code.

No change lands that the decisions in force at a stated position do not
permit. Every decision is accepted by a named human. Every verdict is
reproducible from the position alone. Agents may propose decisions and submit
changes; they may not accept a decision, and they may not land a change by any
route but `land`.

A writ is a written order from an authority that commands or forbids a
specific act. In Writ, an accepted decision is one.

## Status

Bootstrap. The product is defined; nothing is built. The next deliverables
are the specification pages for the four formats and their conformance
suites (`docs/spec/`), then the property suite for guarantees G1 to G10
against an in-memory store, then the first end-to-end slice.

## Documentation

- [`docs/product-definition.md`](docs/product-definition.md) — the authority.
- [`docs/adr/`](docs/adr/) — architecture decisions, numbered, superseded
  rather than edited; [`docs/decisions/`](docs/decisions/) — the same
  decisions as the sets code cites.
- [`docs/spec/`](docs/spec/) — the specification pages, one per format.
- [`docs/roadmap.md`](docs/roadmap.md) — the order of work and the open
  questions.
- [`docs/traceability/`](docs/traceability/) — one record per AI-assisted
  session.
- [`AGENTS.md`](AGENTS.md) — the working method, the gates and the never list.

## Licence

Apache-2.0 ([`LICENSE`](LICENSE), [`NOTICE`](NOTICE), ADR 0003). Writ embeds
[Varve](https://github.com/Hafeok/Varve), which is MPL-2.0; the two compose
because Writ links Varve and never modifies its files.

Developed with AI assistance under human review.
