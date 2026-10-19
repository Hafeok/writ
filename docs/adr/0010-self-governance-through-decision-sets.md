# 0010 — Self-governance: decision sets until Writ's own ledger holds them

## Status

Accepted. 2026-10-18.

## Context

Writ's own decisions are to be kept in Writ's own ledger from the first commit
that can hold them. That commit is some milestones away. Meanwhile code will
cite decisions, and the definition's principle that a rule only in a document
is not a rule applies to Writ's own rules too. `DecisionDriven.Analyzers`
already provides the interim form: a decision set per ADR in
`docs/decisions/`, generated into types that code cites with
`[DesignDecision]`, `[Contract]` and `[HotPath]`, with a filed-but-unaccepted
decision compiling to `[Obsolete]` so that every citation of it is `CS0618`
until the maintainer accepts it.

## Decision

Every ADR has a decision set in `docs/decisions/<adr-title>.md`, in the form
`DecisionDriven.Analyzers` reads (YAML front matter: `set`, `namespace: writ`,
`adr`, `decisions` with `key` and `statement`). The package is referenced
from `Directory.Build.props` as a build-time analyzer, `PrivateAssets="all"`,
and `DdLedgerDirectory` points at `docs/decisions/`.

**A session never writes `accepted-by` or `accepted-at`.** It files the set
with the rulings; the maintainer accepts on the branch. A pull request red on
`CS0618` alone is the expected state of a session's pull request.

When Writ's protocol and store exist, this directory is imported into Writ's
own ledger at one position (`writ import`), the sets become a projection of
the ledger, and this ADR is superseded by the one that makes `writ check`
run over this repository's own code: the product governs itself, and the
first customer of G1 to G10 is this repository.

## Alternatives considered

- **No decision sets until the ledger exists.** Rejected: the first `src/`
  projects would be written under rules nothing checks, and migrating their
  citations later is work with no upside.
- **A Writ-specific interim format.** Rejected: it would be a third format
  (the sets, the ledger, Writ's), and the analyzers' form is already public
  and already read by the generator.

## Consequences

The decision sets in this commit are filed unaccepted; the maintainer's
acceptance is a separate commit by the maintainer, as in Varve. The import
into Writ's own ledger is a roadmap deliverable with a named milestone, and
the acceptance dates in the sets become the acceptances' positions in the
ledger, so nothing is re-decided in the move.
