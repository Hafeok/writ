# 0005 — Writ inherits Varve's hard constraints and its discipline

## Status

Accepted. 2026-10-18.

## Context

Writ embeds Varve (ADR 0006) and ships as one Native AOT binary that runs
embedded, standalone and in a fleet. Every constraint Varve holds to keep an
embedded store AOT-safe, trim-safe and dependency-light is a constraint Writ
needs for the same binary. Restating them with different wording would let
them drift.

Varve's constraints, as `docs/brief.md` in Varve states them, are: 1, 100%
managed; 2, Native AOT and trimming compatible; 3, three hosts from one core
(embedded, server, browser); 4, minimal dependencies, every package by ADR;
5, current LTS .NET and current C#, allocation per quad a defect; 6, no copied
code and a permissive licence (the licence half superseded by Varve ADR 0031).

## Decision

Writ holds Varve's constraints **1, 2, 4 and 5** verbatim, with 5's "per
quad" read as "per quad, per verdict and per term": the projector and the
check are the hot paths.

Constraint 3 is **restated**: one binary, three ways of running it, embedded,
standalone (`writ serve`) and fleet, and the store contract is an abstraction
from the first slice so the property suite runs against an in-memory store.
The browser is not a Writ host; a browser as-of view, if it ever exists, is a
client of `writ serve`.

Constraint 6 is **restated**: no code copied from the ledger it rewrites (ADR
0004); Varve's and the analyzers' code is read for behaviour and referenced
as packages, never copied in. The licence is ADR 0003.

Varve's three design principles apply unchanged: **stable dependencies**
(fixed layers, references strictly downward, same-layer references are
violations, contracts in the lowest layer that can define them), **low
coupling** (no shared mutable state, no static registries, public API
baselines) and **high cohesion** (one package, one reason to change; no
`Common`, `Core`, `Utils`, `Helpers` or `Abstractions` package). Every rule is
an analyzer that fails the build; a rule only in a document is not a rule.

Writ's layer table is **not decided here**. It is decided by the ADR that
creates the first `src/` project, against the packages the definition's
chapter 6 implies, and every project declares `<ArchLayer>` from that commit.

## Alternatives considered

- **Reference Varve's brief by link and hold nothing locally.** Rejected: a
  constraint that lives in another repository can be amended there without
  anyone here noticing; the amendment to Varve's constraint 6 is the example.
- **Adopt all six verbatim including the browser.** Rejected: a browser host
  for a gate that signs and lands commits has no use, and keeping a host no
  one runs would cost a projection backend and a CI job for nothing.
- **Relax constraint 2 for `writ serve`** (allow reflection-based hosting).
  Rejected: one binary; the server is the same executable as the CLI, and a
  reflection path in it is a reflection path in the gate.

## Consequences

Every third-party package needs an ADR before it enters the register (ADR
0009). The trimming, AOT and single-file analyzers run at error severity in
every packable project, and an IL-prefixed id never enters `NoWarn`. The
first `src/` project is blocked on a layering ADR, which is the intended
friction.
