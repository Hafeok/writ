# Specifications

One page per format, each with a conformance suite before any implementation,
and each under read-forever from the first release that writes it (ADRs 0007,
0013).
A page carries a version; a change that an earlier reader could not accept is
a new version, and every version ever released stays readable, tested by
golden files that are never deleted.

| Page | Format | Carried from | State |
|---|---|---|---|
| `vocabulary.md` | the decision vocabulary, `https://decision-driven-design.dk/ns/writ#`: spaces, rules, blends, emergent constraints, levels, mappings, bindings, enumerated decisions, violation shapes, sessions; the named graphs and who writes each; guest vocabularies (`pf:` first) and the rules that keep Writ from extending them; the G8 provenance set; the three `check` outcomes and the open question's `blocks`, `candidates` and `answeredBy`. `writ:realisation` is never minted (ADR 0013) | nothing; new | not written |
| `protocol.md` | acceptance and authority: decisions and versions, supersession, acceptances signing one version hash, reviews, grants with fallback holders and a scope (named graphs narrowed by SHACL targets, evaluated at signing), grants as decisions, baselines, waivers, filed unavailability, agent attribution, derived acceptance for blends and across scopes; two conformance classes, provenance and authority; the header clock; cross-log `basedOn` by pinned version and position; the envelope of a landed graph delta | the ledger's protocol page and its conformance fixtures (ADR 0004) | not written |
| `code-facts.md` | the code-fact graph per language, fact IRIs stable across commits and renames, with provenance (`file` or `compiler`, from the G8 set) on every fact | nothing; new | not written |
| `reports.md` | the reports graph per reporter kind: "input hash → quads", the reporter named as cause, provenance from the G8 set (`runner`, `data`, `telemetry`, `attestation`, `deployment-declared`, `deployment-observed`) | nothing; new | not written |
| `fixtures.md` | a position-pinned, pseudonymised slice of the log plus a manifest, carrying the header clocks (replay as recorded or live) and cross-log `basedOn` references at their pinned versions | the log's own delta format (Varve's change feed) | not written |

The order is the definition's: vocabulary and protocol first, together,
because the protocol signs vocabulary terms; then code facts with the C#
projector; reports with the first reporter, the Product Framework
behavioural-conformance runner; then fixtures with `export`/`import`.

Each page states: the terms, the invariants, the version field, what a
conforming reader must accept and what it must refuse, and where the suite
lives. The suite is version-controlled and never fetched at test time.
