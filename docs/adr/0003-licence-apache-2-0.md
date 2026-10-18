# 0003 — Licence: Apache-2.0

## Status

Accepted. 2026-10-18. **Stated divergence from Varve**, which moved from
Apache-2.0 to MPL-2.0 by its ADR 0031.

## Context

The definition says: the engine is open; Context& architecture packages are
content on it. The engine's value to a customer is G1 to G10 holding over
their code; the packages are the decisions they buy. The licence has to let a
customer embed the engine in a private CI pipeline and a private MCP host
without a reciprocity question, and it has to be the one most corporate
licence policies already allow without review.

Varve, which Writ embeds, is MPL-2.0: file-level copyleft that attaches to
Varve's files and not to code that links against them. Writ links; it does
not modify Varve's files (ADR 0004). The two licences therefore compose
without conflict.

## Decision

Writ is licensed under the Apache License, Version 2.0. `LICENSE` carries the
full text; `NOTICE` carries the copyright line; every `.cs` file carries the
short header in `.editorconfig`'s template. Packages declare
`PackageLicenseExpression` `Apache-2.0`, never a `licenseUrl`.

## Alternatives considered

- **MPL-2.0, as Varve.** Rejected for the engine: a customer embedding Writ in
  a gate will patch it under deadline, and file-level reciprocity on a gate in
  a private pipeline is a conversation we do not want to be having. Varve's
  reason for MPL (an embedded store's files are the asset) does not transfer:
  Writ's asset is the vocabulary and the guarantees, which are specifications
  and tests, not files anyone wants to fork quietly.
- **AGPL-3.0 for `writ serve`, Apache-2.0 for the rest.** Rejected: one binary,
  one licence; a split licence on one binary is a trap for the next person to
  package it.
- **A source-available licence.** Rejected: the open engine is what makes the
  packages worth buying, and a non-OSI licence is refused by the policies the
  Apache choice exists to pass.

## Consequences

Anyone may ship Writ, modified, without returning changes; that is accepted.
The NOTICE obligation (Apache §4(d)) means `NOTICE` ships in every package.
`THIRD-PARTY-NOTICES` is owed the first time a package is embedded rather than
referenced, and Varve's MPL notice goes there then. The maintainer may reverse
this decision by a superseding ADR before the first public release at no
cost; after it, relicensing needs every contributor's agreement.
