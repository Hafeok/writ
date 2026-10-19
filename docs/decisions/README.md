# Decisions

Every Writ ADR as a **decision set**: the rulings code cites as types, in the
form [`DecisionDriven.Analyzers`](https://github.com/Hafeok/decision-driven-analyzers)
reads ([ADR 0010](../adr/0010-self-governance-through-decision-sets.md)).
The ADR in [`docs/adr/`](../adr/) is the narrative and the reasoning; the set
is the list of what was decided, one line each.

One file per ADR, named after the ADR without its number; `namespace: writ`;
a key is `^[A-Z][A-Za-z0-9]{0,63}$`, unique across every file, never renamed,
never reused. **A session never writes `accepted-by` or `accepted-at`**; the
maintainer accepts on the branch, and until then every citation is `CS0618`.
Supersession moves a ruling to the superseding ADR's set under the same key.

When Writ's own ledger can hold decisions, this directory is imported into it
at one position and becomes a projection of the ledger (ADR 0010).

This file has no front matter, so the generator skips it.
