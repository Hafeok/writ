# Specifications

One page per format, each with a conformance suite before any implementation,
and each under read-forever from the first release that writes it (ADR 0007).
A page carries a version; a change that an earlier reader could not accept is
a new version, and every version ever released stays readable, tested by
golden files that are never deleted.

| Page | Format | Carried from | State |
|---|---|---|---|
| `vocabulary.md` | the decision vocabulary, `https://decision-driven-design.dk/ns/writ#`: spaces, rules, blends, emergent constraints, levels, mappings, realisations, enumerated decisions | nothing; new | not written |
| `protocol.md` | acceptance and authority: decisions and versions, supersession, acceptances signing one version hash, reviews, grants with fallback holders, filed unavailability, agent attribution, derived acceptance for blends | the ledger's protocol page and its conformance fixtures (ADR 0004) | not written |
| `code-facts.md` | the code-fact graph per language, with provenance (file or compiler) on every fact | nothing; new | not written |
| `fixtures.md` | a position-pinned, pseudonymised slice of the log plus a manifest | the log's own delta format (Varve's change feed) | not written |

The order is the definition's: vocabulary and protocol first, together,
because the protocol signs vocabulary terms; then code facts with the C#
projector; then fixtures with `export`/`import`.

Each page states: the terms, the invariants, the version field, what a
conforming reader must accept and what it must refuse, and where the suite
lives. The suite is version-controlled and never fetched at test time.
