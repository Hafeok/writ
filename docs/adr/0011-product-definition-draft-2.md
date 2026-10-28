# 0011 — The product definition is Draft 2, through D2.9

## Status

Proposed. 2026-10-28. Supersedes the definition's Draft 1 (2026-10-18,
commit `2411d11`) as the version the repository follows.

## Context

`docs/product-definition.md` is the authority (AGENTS.md), and the
definition is written outside-in: a change to the surface, the formats, the
guarantees or the contracts is a change to the definition first, and the
implementation follows (hard constraint 1). The repository was bootstrapped
against Draft 1 of 2026-10-18 (ADRs 0001 to 0010 cite it as "the
definition").

Draft 2 was written on 2026-10-20 and amended through `[D2.9]` on
2026-10-28. Every design decision since 2026-10-18 was taken against it, not
against what the repository held. The definition changed first; this ADR is
the repository following, and it makes the definition's version a decision
like any other, so that which version was in force at a position is a
question with one answer.

What Draft 2 changes, by its own changelog:

- **Chapter 1.** Writ as the signed boundary between reasoning and
  execution; the log as a store for positioned graphs under more than one
  vocabulary, `writ:` governing and `pf:` the first guest (D2); the promise
  across systems and its honest limit (D2.7).
- **Chapter 3.** Five profiles, `writ`, `writ serve`, `writ gate`,
  `writ mcp` and `writ view`, verbs not configuration (D2.1); the MCP
  section and sessions (D2.2); `land` taking graph deltas as well as
  patches; `check` with three outcomes, clean, violation and open question,
  and the open question's `blocks`, `candidates` and `answeredBy`;
  `accept --baseline` (D2).
- **Chapter 4.** The named graphs by writer; guest vocabularies, `pf:`
  first; acceptance under grant, with scope as named graphs narrowed by
  SHACL targets evaluated at signing; baselines; waivers; reports (D2); the
  header clock as the only clock (D2.3); two conformance classes of the
  protocol, provenance and authority (D2.5); cross-log `basedOn` by pinned
  version and position (D2.6); the Realisation contract renamed Binding and
  narrowed to a What element mapped to a shape in a target, constraints
  evaluating over projector facts and contracts over reporter facts (D2.8).
- **Chapter 5.** Eleven guarantees, not ten: G2 is acceptance under grant;
  G3 covers acceptance, review, grant and waiver; G6 covers open questions
  and session closes at recorded clocks; G7 crosses logs; G8's provenance
  set is `file`, `compiler`, `graph`, `runner`, `data`, `telemetry`,
  `attestation`, `deployment-declared`, `deployment-observed`; G10 keeps
  cross-log references in fixtures; G11 is the ratchet.
- **Chapter 6.** Contracts are modules, Store and Signer mandatory, and
  configuration is a decision or does not exist (D2.1).
- **Chapter 7.** Assemblies per contract with an analyzer forbidding
  cross-references (D2.1); the shipped binary binds the scripted Proposer
  double, and the model-backed Proposer lives in Bailiff (D2.9).
- **Chapter 8.** product-cli's scope is the What alone (D2.4); one decision
  vocabulary; the What is ground and execution space at once; two time axes
  in one log (D2).

## Decision

The repository follows **Draft 2 of the product definition, through
`[D2.9]`**, as committed in `docs/product-definition.md` byte for byte from
the maintainer's text. Draft 1 is superseded. The definition file is ruled
material: a session never edits it; a disagreement with it is a question to
the maintainer, and a change to it comes from the maintainer first.

Where an accepted ADR contradicts Draft 2, it is superseded by its own ADR
citing the Draft 2 tag, never edited:

- ADR 0004's ruling `AnalyzersStayPublicWithTwoModes`, by ADR 0012 (D2.8);
- ADR 0007's ruling `FourFormatsSpecifiedBeforeImplementation`, by ADR 0013
  (D2, D2.5, D2.8).

Where an accepted ADR only cites a Draft 1 count in its reasoning, the
reading is stated here rather than by an edit: "G1 to G10" in ADRs 0003,
0006 and 0010 reads "G1 to G11". No ruling of those ADRs changes meaning.

ADR 0005's `OneBinaryThreeWays` stands. Embedded is `writ`, standalone is
`writ serve`, fleet is several `serve`s; `gate`, `mcp` and `view` are clients
of a `serve`, not ways of running the store. The prose that describes the
binary says five profiles; the ruling is not superseded.

Every later version of the definition is filed the same way: an ADR naming
the version and the tags, superseding this one.

## Alternatives considered

- **Edit the prose and leave the ledger alone.** Rejected: the definition is
  what every ADR rests on, and a change to it that the ledger does not record
  makes "which definition was in force when this was decided" unanswerable,
  which is the question Writ exists to answer.
- **Amend ADRs 0003, 0006 and 0010 with add-only blocks for G1 to G11.**
  Rejected: the count appears in their reasoning, not their rulings, and
  stating the reading once here touches no accepted record.
- **Supersede every ADR that cites "the definition".** Rejected: a citation
  of the definition as the authority is not a dependence on Draft 1; only
  the rulings Draft 2 contradicts are superseded.

## Consequences

The prose that described Draft 1 is reconciled in the same pull request:
`AGENTS.md`, `README.md`, `docs/spec/README.md` and `docs/roadmap.md`.
`writ:realisation` is never minted (ADR 0013). `Writ.Store.Abstractions`
(chapter 7.1) stands against ADR 0005's ban on an `Abstractions` package;
the ADR that creates the first `src/` project decides it, and until then the
ban stands. The definition's version enters Writ's own ledger with the other
ADRs when `writ import` exists (ADR 0010).
