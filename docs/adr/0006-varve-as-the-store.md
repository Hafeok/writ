# 0006 — Varve is the store, embedded, file backend kept in Git

## Status

Accepted. 2026-10-18.

## Context

The promise needs positions, as-of reads at any closed position, a diff
between two positions, per-graph conditional commits and a header chain that
a landed commit can cite as `Decisions-Head`. Varve has all five as its model
rather than as features over a different model: the log is the source of
truth, every index is a projection, and `derived/` is rebuildable. No other
managed store has that shape, and constraint 1 (ADR 0005) rules out every
native one.

## Decision

The `Store` contract (definition, chapter 6) is implemented over Varve,
referenced as NuGet packages (`Varve.Store` and what it needs; `Varve.Sparql.Store`
for the check), never as source. In the embedded host the log is a Varve
file-backend dataset in the repository, with `derived/` ignored by Git and
rebuilt. In the standalone host the server alone writes the dataset and CLIs
commit through it.

The contract is defined over the vocabulary, not over Varve's types, so that
the property suite for G1 to G10 runs against an in-memory implementation
first and the Varve implementation second, and so that Varve's API can move
while it is preview without moving the definition.

Writ puts nothing Writ-specific into Varve (ADR 0004). What Writ needs that
Varve lacks is filed as a Varve issue. **One such gap is known at this
commit: Varve has no SHACL.** The definition's chapter 7 names SHACL and
SPARQL `CONSTRUCT` as the rule languages; until `Varve.Shacl` exists the
check is SPARQL only, and whether the first slice waits for SHACL or ships
with SPARQL alone is an open question on the roadmap, decided by the
maintainer and not by this ADR.

## Alternatives considered

- **A purpose-built log for decisions only** (an append-only file of signed
  records, no RDF). Rejected: the vocabulary is RDF and the rules are SPARQL
  and SHACL; a second store for the decisions would put a translation between
  a decision and its verdict, which hard constraint 8 forbids in spirit and
  G7 makes expensive.
- **Oxigraph, or any native store, through a wrapper.** Out under constraint 1.
- **Git itself as the log** (decisions as files, positions as commits).
  Rejected: Git gives positions and diffs over files, not over quads, and
  no per-graph conditional commit; the check would re-parse the world at every
  position.

## Consequences

Writ moves at Varve's preview cadence until Varve is 1.0; every Varve bump is
a register change with the breaking entries in its commit body (ADR 0009).
The SHACL gap is Varve's to close and Writ's to wait for or to work around,
and that choice is recorded when it is made. The dataset directory in a
repository is a format Writ must keep readable under read-forever (ADR 0007),
which Varve's own format-version rule already provides.
