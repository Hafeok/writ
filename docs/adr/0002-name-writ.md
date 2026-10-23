# 0002 — The name is Writ

## Status

Accepted. 2026-10-18.

## Context

A writ is a written order from an authority that commands or forbids a
specific act. In this product an accepted decision is one: it states what may
be done, who accepted it, and from which position it is in force. The first
choice, Warrant, was dropped on 2026-10-18 because `warrant-dev` is an active
Apache-2.0 authorization service with a `warrant` CLI and `warrant.dev`.

Availability was checked on 2026-10-18 (definition, appendix): no `Writ` or
`Writ.*` package on NuGet; `writ` on GitHub is an inactive personal account;
`writ` on npm is a small literate-programming tool, which Writ never collides
with in use because it ships no npm package; `writ.dev` is taken by something
that refuses automated fetching; EU trademark not checked.

## Decision

The product, the repository, the binary and the package prefix are `Writ`.
The command is `writ`. The vocabulary prefix is `writ:` (ADR 0007). "Warrant"
survives inside Writ as the term for what an acceptance confers on a decision
at a position.

## Alternatives considered

- **Warrant.** The first choice, and a better fit for "what an acceptance
  confers". Rejected on the collision above: a user searching for the CLI
  would find someone else's.
- **A longer compound name (`decision-gate`, `writ-gate`).** Rejected: the
  binary is typed often, and the word alone carries the meaning.

## Consequences

`writ.dev` cannot be assumed; the vocabulary IRI is therefore under a domain
the maintainer owns (ADR 0007). An EU trademark search is owed before the
first public release and is on the roadmap. The npm overlap costs nothing but
search results.
