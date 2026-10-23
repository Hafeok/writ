---
set: varve-as-the-store
namespace: writ
adr: 0006
decisions:
  - key: VarveIsTheStore
    statement: "The Store contract is implemented over Varve referenced as NuGet packages, never as source"
  - key: StoreContractOverTheVocabulary
    statement: "The Store contract is defined over the vocabulary, not Varve's types, so the property suite runs against an in-memory store first"
  - key: EmbeddedLogIsAFileBackendDatasetInGit
    statement: "In the embedded host the log is a Varve file-backend dataset in the repository, with derived/ ignored by Git and rebuilt"
  - key: StandaloneServerAloneWrites
    statement: "In the standalone host the server alone writes the dataset, and CLIs commit through it"
  - key: ShaclGapIsOpen
    statement: "Varve has no SHACL at this commit; whether the first slice waits for it or ships with SPARQL alone is an open roadmap question for the maintainer"
---

The rulings of [ADR 0006](../adr/0006-varve-as-the-store.md). Filed unaccepted by the session.
