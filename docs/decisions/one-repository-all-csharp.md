---
set: one-repository-all-csharp
namespace: writ
adr: 0004
decisions:
  - key: OneRepositoryAllCSharp
    statement: "hafeok/writ holds the vocabulary, protocol, suites, CLI, server, MCP host, gate, view and the merged ledger, entirely in .NET and C#"
  - key: LedgerRewrittenNotPorted
    statement: "The ledger's protocol page and conformance fixtures carry over; its code does not, and no line of it is copied"
  - key: WritImportReadsLegacyStores
    statement: "writ import reads the existing ledger stores so .decisions/ directories migrate, and the existing tool is retired when the rewrite passes the same suite"
  - key: NothingWritSpecificInVarve
    statement: "Varve stays in its own repository; Writ is an embedded consumer, and a need Varve does not meet is a Varve issue, never a fork"
---

The rulings of [ADR 0004](../adr/0004-one-repository-all-csharp.md). Filed unaccepted by the session. `AnalyzersStayPublicWithTwoModes` moved to [ADR 0012](../adr/0012-repository-boundaries-under-draft-2.md)'s set, superseded.
