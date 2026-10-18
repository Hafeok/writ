---
set: self-governance-through-decision-sets
namespace: writ
adr: 0010
decisions:
  - key: DecisionSetsInTheAnalyzersForm
    statement: "Every ADR has a decision set in docs/decisions/ in the form DecisionDriven.Analyzers reads, generated into the types code cites"
  - key: ASessionNeverWritesAcceptance
    statement: "A session never writes accepted-by or accepted-at; the maintainer accepts on the branch, and a pull request red on CS0618 alone is expected"
  - key: SetsBecomeAProjectionOfWritsLedger
    statement: "When Writ's protocol and store exist, docs/decisions/ is imported into Writ's own ledger at one position and becomes a projection of it"
---

The rulings of [ADR 0010](../adr/0010-self-governance-through-decision-sets.md). Filed unaccepted by the session.
