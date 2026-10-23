# 0001 — Record architecture decisions

## Status

Accepted. 2026-10-18.

## Context

The product definition requires an ADR for every decision, numbered, with
alternatives and consequences, and requires that a proposal contradicting an
accepted ADR says so and supersedes it rather than diverging silently. That
needs a format and a lifecycle before the second decision exists.

Writ has a second obligation Varve did not have at its first commit: the
product governs itself. Writ's own decisions are to be kept in Writ's own
ledger from the first commit that can hold them. Until then they are files.

## Decision

ADRs live in `docs/adr/NNNN-kebab-title.md`, numbered from 0001, allocated in
order, never reused, never renumbered. Each has five sections in this order:
**Status**, **Context**, **Decision**, **Alternatives considered**,
**Consequences**. An ADR with no alternatives is a note, not a decision.

Status is `Proposed`, `Accepted`, `Superseded by NNNN` or `Rejected`, with a
date. It is `Accepted` when the product definition already settles the matter
or the maintainer has agreed it. An accepted ADR is not edited; it is
superseded by a new one, and only its Status line changes. A dated, add-only
amendment block is allowed where it adds and changes no meaning (Varve ADR
0068); a change of meaning is a supersession.

Every ADR has a decision set in `docs/decisions/` (ADR 0010), which is the
form code cites. When Writ's ledger can hold decisions, every ADR in force is
imported into it at one position and the set files become a projection of the
ledger; the markdown narrative stays.

A decision that binds code is enforced or it does not bind: where an ADR can
be an analyzer rule, it names the rule.

## Alternatives considered

- **Wait for Writ's own ledger and file nothing until then.** Rejected: the
  decisions that shape the ledger would then be the only ones not in it, and
  nothing would check that the first slices follow them.
- **Varve's format verbatim, by reference.** Taken in substance; written out
  here because a reader of this repository should not need another one to
  know what a file in `docs/adr/` is.
- **MADR or Nygard verbatim.** Same reasoning as Varve ADR 0001: five sections
  with *Alternatives considered* required.

## Consequences

Every decision costs a file, which makes an undecided question visible by its
absence. Superseded ADRs accumulate and are read Status line first. Writ owes
itself an `import` of its own ADRs the moment the ledger exists; that is on the
roadmap as part of the first milestone that lands the protocol.
