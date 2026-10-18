# Roadmap

The order of work is the definition's chapter 7, with the process work that
has to precede the first `src/` project. Each milestone ends in a release
once a publishing ADR exists.

| Milestone | Delivers | Needs first |
|---|---|---|
| Bootstrap (#1) | definition, ADRs 0001–0010, build policy, AGENTS.md | — |
| Gates | `eng/issue-refs`, `eng/dco`, `eng/identities`, `eng/dependency-register`, `eng/ci.cs`, the ruleset on `main` | ADR 0008 accepted |
| Vocabulary and protocol | `docs/spec/vocabulary.md`, `docs/spec/protocol.md`, the Turtle served at the IRI, the ledger's conformance fixtures carried over, derived acceptance stated | the domain serving the IRI (ADR 0007) |
| Property suite | G1 to G10 as property tests against an in-memory store; the layering ADR; the first `src/` projects | both pages |
| First slice | the C# file projector, the layer rule, `check` end to end over this repository | `docs/spec/code-facts.md`; the SHACL question below |
| `land` | the trailers, the minimum-position rule, the status check; Writ gates itself and ADR 0008 is superseded | first slice |
| MCP server | the verbs minus `accept` and `review`, over stdio | `land` |
| Proposer | the contract, a scripted double, a tool-calling model behind it | MCP |
| `apply` | declarations converged with the log, G9 | — |
| As-of view, `serve` | the standalone host, the inbox, the remote gate | — |
| Fixtures | `docs/spec/fixtures.md`, `export`/`import`, G10, `writ import` of legacy ledger stores and of `docs/decisions/` | — |

## Open questions

Each has an owner and the milestone that must decide it.

1. **SHACL.** Varve has no SHACL at this commit (ADR 0006). The first slice
   either waits for `Varve.Shacl` or ships with SPARQL `CONSTRUCT` alone and
   adds `sh:rule` and violation shapes when Varve can evaluate them. Owner:
   the maintainer. Due: before the first slice.
2. **Blends.** Whether rules with emergent constraints earn their place is
   decided by the Varve blend spike of 2026-10-18 (definition, chapter 4). The
   vocabulary keeps the terms either way. Due: the vocabulary page.
3. **Action grammar.** Whether realisations can generate code from accepted
   decisions rather than only check it (definition, chapter 8). Additive;
   no milestone yet.
4. **The IRI's home page and the EU trademark search** (ADRs 0002, 0007).
   Owner: the maintainer. Due: before the vocabulary page is published.
5. **Publishing and versioning.** No ADR yet; MinVer is registered under
   0009 meanwhile. Due: before the first package is pushed.
