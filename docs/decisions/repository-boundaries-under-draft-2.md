---
set: repository-boundaries-under-draft-2
namespace: writ
adr: 0012
decisions:
  - key: AnalyzersStayPublicWithTwoModes
    statement: "DecisionDriven.Analyzers stays in its own repository and runs in two modes behind the same packages: rules in Roslyn, or rules in the graph with Roslyn as projector and binding"
  - key: ProductCliOwnsTheWhatAlone
    statement: "product-cli stays in its own repository, authors the pf: graph and owns pf:, and its scope is the What alone; the How, seams, delivery and every decision and signature live in Writ, which never extends pf:"
  - key: ModelBackedProposerLivesInBailiff
    statement: "Writ's binary binds the Proposer contract to its scripted double only; the model-backed Proposer lives in Bailiff and reaches Writ through writ mcp as an agent identity"
---

The rulings of [ADR 0012](../adr/0012-repository-boundaries-under-draft-2.md). `AnalyzersStayPublicWithTwoModes` moves here from [ADR 0004](../adr/0004-one-repository-all-csharp.md)'s set under the same key, superseded ([D2.8]). Filed unaccepted by the session.
