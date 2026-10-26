---
set: record-architecture-decisions
namespace: writ
adr: 0001
decisions:
  - key: FiveSectionAdr
    statement: "An ADR has Status, Context, Decision, Alternatives considered and Consequences, in that order, and one with no alternatives is a note"
  - key: AcceptedAdrIsNotEdited
    statement: "An accepted ADR changes only by a superseding ADR or a dated add-only amendment; a change of meaning is a supersession"
  - key: EveryAdrHasADecisionSet
    statement: "Every ADR has a decision set in docs/decisions/ in the form DecisionDriven.Analyzers reads"
  - key: AdrsMoveIntoWritsOwnLedger
    statement: "Every ADR in force is imported into Writ's own ledger at one position when the ledger can hold it, and the sets become a projection"
---

The rulings of [ADR 0001](../adr/0001-record-architecture-decisions.md), one line each. Filed unaccepted by the session; the maintainer accepts on the branch.
