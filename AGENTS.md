# AGENTS.md — Writ

Writ makes architecture decisions enforceable on code written by agents. A
writ is a written order from an authority that commands or forbids a specific
act; in Writ an accepted decision is one.

**`docs/product-definition.md` is the authority**, written outside-in:
promise, roles, surface, formats, guarantees, contracts, then implementation.
Chapters 1 to 6 are the product; chapter 7 may change without them changing.
Read it before proposing anything structural. Where this file disagrees, the
definition wins.

## The promise

No change lands that the decisions in force at a stated position do not
permit. Every decision is accepted by a named human. Every verdict is
reproducible from the position alone. Agents may propose decisions and submit
changes; they may not accept a decision, and they may not land a change by
any route but `land`.

## Hard constraints

1. **Outside-in.** A change to the surface, formats, guarantees or contracts
   is a change to the definition first; the implementation follows.
2. **Varve's constraints, inherited** (ADR 0005): 100% managed; Native AOT and
   trimming compatible; one binary, three ways of running it; minimal
   dependencies, every package by ADR in the register (ADR 0009); current LTS
   .NET and current C#, allocation per quad, per verdict and per term a
   defect; no copied code.
3. **One repository, all C#** (ADR 0004). The ledger is rewritten here, not
   ported; the analyzers and Varve stay in their own repositories.
4. **No API keys, ever.** OIDC and workload identity for servers and CI; SSH
   signatures for acceptance; heavier schemes behind the `Signer` seam.
5. **Agents never accept** (G3). No code path, tool, flag or configuration
   lets an agent identity produce an acceptance or a review. Not negotiable
   for convenience, demos or tests.
6. **Code commits cite a position.** `Decisions-Position` and
   `Decisions-Head` on every landed commit; `land` is the only write path.
7. **Formats under read-forever from the first release** (ADR 0007). Each has
   a specification page and a conformance suite before any implementation.
8. **Nothing learned sits between a decision and a verdict.** The proposer
   may be a model; the check is SPARQL and SHACL over a log at a position.

**Stable dependencies**, references strictly downward, same-layer references
are violations. **Low coupling**: no shared mutable state, no static
registries, public API baselines. **High cohesion**: no `Common`, `Core`,
`Utils`, `Helpers` or `Abstractions`. **Every rule is an analyzer that fails
the build.** The layer table is decided by the ADR that creates the first
`src/` project; every project then declares `<ArchLayer>`.

## How we work

Specification, then ADR, then code. Small vertical slices ending in passing
tests, never scaffolding that compiles and does nothing.

- **Check every proposal against the accepted ADRs.** If it contradicts one,
  say so and propose a superseding ADR; never diverge quietly, never edit an
  accepted one (ADR 0001). When one artefact changes, list what else must:
  definition, ADR, decision set, code, rule page, baseline.
- Cite the specification section (SPARQL, SHACL, RDFC-1.0, PROV-O, the Writ
  vocabulary and protocol). Say so rather than guess. Flag anything breaking
  AOT, trimming or the single binary the moment it appears. Disagree with
  reasons.
- Never take a version from memory: resolve it from nuget.org into
  `Directory.Packages.props` with `Adr="NNNN"` (ADR 0009).
- **Every ADR has a decision set** in `docs/decisions/`, and code cites a
  ruling as a type: `[DesignDecision(typeof(<Set>.<Key>), Scope = …)]`,
  `[Contract(typeof(<Set>.<Key>), Role = "…")]`, `[HotPath(typeof(<Set>.<Key>))]`
  (ADR 0010). A finding is fixed or answered by a decision; never `#pragma`,
  `[SuppressMessage]` or an `.editorconfig` downgrade for a `DD` or `WRIT`
  id. **A session never writes `accepted-by`**; a pull request red on
  `CS0618` alone is the expected state.
- When asked for code: complete, compiling, idiomatic modern C#, with tests;
  stubs marked and listed. Prose plain and precise; diagrams as Mermaid when
  structure is easier to see than read.

## Every session (ADR 0008)

- **Read first, plan first, wait for approval** before writing code.
- **One pull request** from the session's branch; when two sessions run in
  parallel, the one that lands second merges `main` and reconciles.
- **Every commit**: a conventional commit, one logical change, `Refs #N` in
  the body (a `Closes #N` only as a trailer line of its own),
  `Signed-off-by:` naming the responsible human in `eng/identities.json`,
  committed as the agent identity and SSH-signed when the sandbox can sign.
  **A commit message never carries a model's identifier**; prose elsewhere
  says "developed with AI assistance under human review" and names no
  product.
- **A traceability record** in `docs/traceability/`, named
  `YYYY-MM-DD-issue-N-<slug>.md`, with the prompt, the tool and the model
  named exactly, the report and the commits.
- **`main` accepts only checked commits**, fast-forwarded at an approved
  head. Until the `eng/` gates and the ruleset exist, the maintainer is the
  gate. A session never tags.

## Commands

```bash
dotnet build Writ.slnx -c Release     # once a solution exists: zero warnings, or it is broken
```

There is no `eng/ci.cs` yet. The first gates to port from Varve are
`issue-refs`, `dco`, `identities` and `dependency-register`, before the first
`src/` project (`docs/roadmap.md`).

## State

Bootstrap (#1): the definition (Draft 1), ADRs 0001–0010 with their decision
sets filed unaccepted, the build and dependency policy, this file. No `src/`,
no solution, no gates. Next: the vocabulary and protocol specification pages
with their conformance suites (`docs/spec/README.md`).

## Never

- An acceptance or a review produced by an agent identity, by any path.
- A landed change without `Decisions-Position` and `Decisions-Head`, or a
  write path beside `land`.
- An API key, or any credential scheme other than OIDC and SSH signatures.
- A learned model between a decision and a verdict.
- A format written before its specification page and conformance suite
  exist, or a golden file deleted.
- A native dependency, reflection or `Reflection.Emit` in shipped code, an
  IL-prefixed id in `NoWarn`, a version from memory, a package without an
  ADR.
- A commit with no issue reference or no sign-off, or one carrying a model's
  identifier; a long-lived branch; editing an accepted ADR; an
  `accepted-by` written by a session; a suppression of a `DD` or `WRIT` rule.
- Code copied from the ledger, Varve or the analyzers; anything Writ-specific
  put into Varve.
- A `.cs` file without the Apache-2.0 header; a placeholder body not marked
  as a stub and reported.
