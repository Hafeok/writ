# 0013 — Formats under Draft 2: every chapter 4 format specified first, the G8 provenance set, no `writ:realisation`

## Status

Proposed. 2026-10-28. Supersedes ADR 0007's ruling
`FourFormatsSpecifiedBeforeImplementation` on its acceptance; ADR 0007's
other rulings stand.

## Context

ADR 0007 fixed the vocabulary IRI, read-forever, and four formats with a
page and a suite before any implementation: the vocabulary, the protocol,
the code-fact graph "with provenance (file or compiler) on every fact", and
fixtures.

Draft 2 (ADR 0011) contradicts that ruling in two places and adds to it:

- **`[D2]`** Chapter 4 adds **reports** as a format: a reporter is a
  projector whose input is not a repository, and its quads land in a reports
  graph per reporter kind with the reporter named as cause. Chapter 4 also
  adds the named graphs by writer, guest vocabularies, grants with scope,
  baselines and waivers, all of which a page must specify.
- **`[D2]`, `[D2.8]`** G8's provenance is a closed set of nine: `file`,
  `compiler`, `graph`, `runner`, `data`, `telemetry`, `attestation`,
  `deployment-declared`, `deployment-observed`. "File or compiler" is two of
  them.
- **`[D2.5]`** The protocol page defines two conformance classes,
  provenance-conformant and authority-conformant.
- **`[D2.3]`, `[D2.6]`** The header clock is the only clock and fixtures
  carry it; a decision rests on a decision in another log by `writ:basedOn`
  at a pinned version hash and position.
- **`[D2.8]`** `writ:realisation` is never minted; the term is Binding.

## Decision

1. **`FourFormatsSpecifiedBeforeImplementation`, superseded.** Every format
   of the definition's chapter 4 has a specification page and a conformance
   suite before any implementation: the vocabulary (with the named graphs
   and guest vocabularies), the protocol (both conformance classes, grants
   with scope, baselines, waivers, cross-log `basedOn`, sessions), code
   facts, reports, and fixtures (with the header clocks). Every projected or
   reported fact carries its provenance from the G8 set. The ruling keeps
   its key, which is never renamed; the "four" in it is historical.
2. **`writ:realisation` is never minted** (D2.8). The term for a What element
   mapped to a shape in a target is `binding`. No term, page, assembly,
   namespace, package or analyzer id is named "Realisation"; "realises" as a
   verb (`realises_version`, "code realising the What") is not a term and
   stays.

## Alternatives considered

- **Fold reports into the code-fact page as one "projected facts" format.**
  Rejected: the definition gives reports their own section and their own
  named graph per reporter kind, with a different contract ("input hash →
  quads") and different causes; one page for both would specify two
  contracts under one version field.
- **Mint `writ:realisation` as a deprecated alias of `writ:binding`.**
  Rejected: ADR 0007's never-rename rule protects terms that were minted;
  this one never was, and minting it only to deprecate it would put in the
  vocabulary a term D2.8 says never to mint.
- **Leave G8's set to the code-fact page.** Rejected: the set is shared by
  code facts, reports and guest graphs, and a verdict names provenance from
  all three; it belongs to the vocabulary, cited by each page.

## Consequences

`docs/spec/README.md` lists five pages, `reports.md` among them, and the
vocabulary page owns the named graphs, the guest-vocabulary rules and the G8
set. Milestone #5's scope grows by the named graphs, scope, baselines,
waivers and the two conformance classes, which chapter 7's order of work
already names. The reports page is due with the first reporter, the Product
Framework behavioural-conformance runner.
