# 0009 — Dependency policy and the register

## Status

Accepted. 2026-10-18.

## Context

Constraint 4 (ADR 0005): minimal dependencies, and every third-party package
needs an ADR. A policy that is not a list is not checkable, and a list that is
not the build's own input drifts from what is actually referenced. Varve
answered this with ADR 0009: central package management, every
`PackageVersion` carrying the ADR that admits it, and a gate that fails the
build when the attribute is missing or cites an ADR that does not exist.

## Decision

`Directory.Packages.props` is the register. Central package management is on
with transitive pinning; a project file carries no version. Every
`PackageVersion` carries `Adr="NNNN"`. A package admitted by this policy alone
cites 0009; one admitted by a specific decision cites that decision. A package
confined to some projects carries `Scope=` naming them.

Versions are resolved from nuget.org when a package is added, never taken
from memory. Latest stable is the default. Two named exceptions:

- the Roslyn floor for analyzer authoring is the line shipped with the first
  .NET 10 SDK, because an analyzer must load in the oldest IDE compiler it
  claims to support;
- Varve and `DecisionDriven.Analyzers` are taken at their **latest
  prerelease**, because both are preview and Writ moves with them (ADR 0006);
  a bump carries the breaking entries from their changelogs in its commit
  body.

The gate (`eng/dependency-register.cs`, ported from Varve) runs in CI once
there is a project to check; until then the attribute is required by this
ADR and checked by review.

## Alternatives considered

- **A separate `DEPENDENCIES.md`.** Rejected: a second list drifts from the
  first, and nothing in the build reads it.
- **No ADR for build-time-only packages** (analyzers, test frameworks).
  Rejected: build-time packages run code at build time in every contributor's
  environment, and their supply chain is the project's.
- **Take Varve at a pinned stable version and lag.** Rejected: there is no
  stable version yet, and lagging a preview whose API moves costs more
  reconciliation than tracking it.

## Consequences

Adding a package is a two-file change plus, usually, an ADR. The register is
the one place a dependency question is answered. Tracking previews means a
Varve release can break Writ's build on the day the register is bumped, which
is accepted and bounded by the store contract (ADR 0006).
