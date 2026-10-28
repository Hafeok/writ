# 0007 — The vocabulary IRI, and formats under read-forever from the first release

## Status

Accepted. 2026-10-18. Ruling `FourFormatsSpecifiedBeforeImplementation`
superseded by 0013 (proposed 2026-10-28) on its acceptance.

## Context

The vocabulary is the product. Its terms are minted at an IRI, cited in every
decision, every acceptance and every landed commit's log entry, and read back
at any position for as long as the log exists. The IRI can never move, and
nothing Writ writes may become unreadable.

`writ.dev` is not available (ADR 0002). The maintainer owns
`decision-driven-design.dk`, the brand under which the analyzers and Varve's
packages are already published (`Authors` in Varve's build targets).

## Decision

The vocabulary namespace is

    https://decision-driven-design.dk/ns/writ#

with the prefix `writ:`. It is served at that IRI as the specification page
and, by content negotiation, as Turtle. The IRI is permanent: a term is never
renamed, a deprecated term stays defined with `owl:deprecated true`, and a
second vocabulary is a second namespace, never a change to this one.

**Four formats have a specification page and a conformance suite before any
implementation**, and are under read-forever from the first release that
writes them:

1. the decision vocabulary (`docs/spec/vocabulary.md`);
2. the acceptance and authority protocol (`docs/spec/protocol.md`), carried
   over from the ledger and extended with derived acceptance;
3. the code-fact graph (`docs/spec/code-facts.md`), per language, with
   provenance (file or compiler) on every fact;
4. the fixture format (`docs/spec/fixtures.md`): a position-pinned,
   pseudonymised slice of the log plus a manifest.

Read-forever means: every version of each format ever written by a release
is read by every later release, tested by golden files that are never
deleted. A version number in the format is what makes a second version
possible; the first page carries one.

## Alternatives considered

- **`https://w3id.org/writ/ns#`.** A permanent redirect under community
  stewardship, free. Rejected for now: w3id is one more organisation whose
  continued operation the IRI depends on, and the maintainer already
  operates a domain. Varve uses w3id (`https://w3id.org/varve/ns#`); that is
  a precedent, not a requirement, and the two may differ.
- **`https://writ.decision-driven-design.dk/ns#`.** A subdomain per product.
  Rejected: a subdomain is a DNS record someone has to keep, and a path is
  not. `/ns/writ#` leaves room for sibling vocabularies under one host.
- **Implement first, specify from the implementation.** Rejected by hard
  constraint 7, and for the reason behind it: a format that exists only as
  code has no version and no golden files, so the first incompatible change
  breaks every log written before it.

## Consequences

The domain is now infrastructure: its registration and the page it serves
are a maintainer obligation listed on the roadmap, with the Turtle served
from this repository's `docs/spec/` so the IRI and the specification cannot
disagree. Each format costs a page, a version field, a suite and golden files
before it earns a line of implementation. That is the intended cost.
