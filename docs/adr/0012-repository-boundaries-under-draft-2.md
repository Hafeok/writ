# 0012 — Repository boundaries under Draft 2: projector and binding, product-cli's What, Bailiff's Proposer

## Status

Proposed. 2026-10-28. Supersedes ADR 0004's ruling
`AnalyzersStayPublicWithTwoModes` on its acceptance; ADR 0004's other
rulings stand.

## Context

ADR 0004 placed three bodies of work: the ledger rewritten in Writ, the
analyzers and Varve in their own repositories. Its third ruling reads the
analyzers' second mode as "Roslyn reduced to projector and realisation",
after Draft 1's Realisation contract.

Draft 2 (ADR 0011) changes that and adds two boundaries ADR 0004 did not
draw:

- **`[D2.8]`** The Realisation contract is renamed **Binding** and narrowed
  to the How's kind 2: a What element mapped to the shape that satisfies it
  in one target. Constraints evaluate over a projector's facts and contracts
  over a reporter's facts, with no binding. Chapter 6 now reads "rules in the
  graph with Roslyn reduced to projector and binding".
- **`[D2.4]`** product-cli stays in its own repository, and its scope is the
  What alone: Product Framework §3 and the behavioural-conformance wire
  protocol of §6.3.1, rewritten in .NET on Varve with its own draft log. The
  How (§4), work units and seams (§5), delivery and direction (§7), and every
  decision and signature live in Writ. Writ consumes product-cli's export and
  never extends `pf:`.
- **`[D2.9]`** The shipped binary binds the scripted Proposer double; the
  model-backed Proposer lives in Bailiff and drives Writ through MCP. No model
  SDK is in Writ's binary.

## Decision

1. **`AnalyzersStayPublicWithTwoModes`, superseded.** `DecisionDriven.Analyzers`
   stays in its own repository and runs in two modes behind the same
   packages: rules in Roslyn, or rules in the graph with Roslyn reduced to
   projector and binding. The ruling keeps its key; only its statement
   changes, from "realisation" to "binding" (D2.8).
2. **product-cli owns the What and nothing else** (D2.4). It authors the
   `pf:` graph and owns the `pf:` vocabulary; Writ lands its export as a
   graph delta, signs it, and never extends `pf:`. Every decision and every
   signature, including those over the How, seams and delivery, is in Writ.
3. **The model-backed Proposer lives in Bailiff** (D2.9). Writ's binary binds
   the Proposer contract to its scripted double only; a model client, its SDK
   and its credentials are never a Writ dependency. Bailiff reaches Writ as
   an agent identity through `writ mcp`, under G3 like any other.

## Alternatives considered

- **Supersede ADR 0004 whole.** Rejected: four of its five rulings are
  untouched by Draft 2, and restating them would move keys for no change of
  meaning.
- **Keep "realisation" as a synonym in the analyzers' description.**
  Rejected by D2.8: the word is retired as a term, `writ:realisation` is
  never minted (ADR 0013), and a second name for one contract is a second
  thing a reader has to check is the same.
- **Ship a model-backed Proposer in the binary behind a flag.** Rejected by
  D2.9 and by chapter 6: configuration is a decision or does not exist, and a
  model SDK in the binary is a dependency every gate and every server
  carries for a part that "must stay swappable".

## Consequences

The analyzers' two-mode release is coordinated as "projector and binding";
roadmap milestone #14 is renamed to match. Roadmap milestone #10 delivers the
Proposer contract, the scripted double and `propose` over it; the
Azure AI Foundry proposer it named under Draft 1 is Bailiff's, not Writ's,
and no model package enters the register (ADR 0009). A `pf:` change Writ
needs is a product-cli issue, in product-cli's terms.
