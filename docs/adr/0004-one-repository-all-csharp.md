# 0004 — One repository, all C#; the ledger is rewritten, the analyzers and Varve stay out

## Status

Accepted. 2026-10-18.

## Context

Three existing bodies of work meet in Writ: Varve (the event-sourced RDF
store), the decision-driven analyzers (`DecisionDriven.Analyzers`, Roslyn,
public), and the decision ledger (`ledger-core`, from `product-cli`, with its
protocol page and conformance fixtures). Each has its own repository, cadence
and language. The definition's chapter 8 settles where each goes.

## Decision

1. **One repository, `hafeok/writ`**, holds the vocabulary, the protocol, the
   conformance and property suites, the CLI, the server, the MCP host, the CI
   gate, the as-of view and the merged ledger. It is entirely .NET and C#.
2. **The ledger is rewritten here, not ported.** Its protocol page and its
   conformance fixtures carry over, as the specification and the suite the
   rewrite must pass. Its code does not; no line of it is copied. `writ
   import` reads the existing stores so `.decisions/` directories migrate,
   and the existing tool is retired when the C# implementation passes the
   same suite.
3. **The analyzers stay in their public repository** and run in two modes
   behind the same packages: rules in Roslyn, or rules in the graph with
   Roslyn reduced to projector and realisation (definition, chapter 6). Writ
   references them; it does not absorb them.
4. **Varve stays in its own repository.** Writ is an embedded consumer (ADR
   0006) and puts nothing Writ-specific into Varve. A need Writ has that Varve
   does not meet is a Varve issue, in Varve's terms, never a fork.
5. **The `dec` orchestrator stays out.**

## Alternatives considered

- **A monorepo with Varve and the analyzers as submodules or subtrees.**
  Rejected: the three have different release cadences and the analyzers are
  consumed by projects that never see Writ; one trunk would couple three
  schedules for the convenience of one.
- **Port the ledger (translate its code).** Rejected: the ledger's value is its
  protocol and fixtures, and a translation would carry its host's idioms into
  a repository whose constraints (ADR 0005) it was not written under.
- **Keep the ledger as a separate package Writ depends on.** Rejected: the
  protocol is Writ's signature format and G2 and G3 are stated over it; one
  promise, one repository.

## Consequences

The ledger's suite is the first conformance suite Writ must pass, before it
writes its own. A change to the protocol is a change to the definition first
(hard constraint 1). The analyzers' two modes are a contract Writ depends on
and does not control; a change there is coordinated through that repository's
issues. The `writ import` path is a deliverable, not a courtesy, and is on the
roadmap.
