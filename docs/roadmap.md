# Roadmap

Milestones are the definition's chapter 7 order, with the process work that
must precede the first `src/` project. Each milestone is tracked by an issue,
and every commit references one (ADR 0008). Each is one issue, one or more
pull requests, and one release descriptor naming that issue, once the
publishing ADR exists (Gates); a milestone is complete when its descriptor is
cut, and not before. Release numbers are not fixed in advance: each milestone
takes the next free `0.1.0-preview.N` when it lands.

## At a glance

| Milestone | Issue | Depends on | Status |
|---|---|---|---|
| Bootstrap | [#1](https://github.com/Hafeok/writ/issues/1) | — | PR #3 |
| Gates and the ruleset | [#4](https://github.com/Hafeok/writ/issues/4) | #1 | |
| Vocabulary and protocol | [#5](https://github.com/Hafeok/writ/issues/5) | #4 (or review as the gate) | |
| Property suite and the first projects | [#6](https://github.com/Hafeok/writ/issues/6) | #4, #5 | |
| First slice: the C# file projector and the layer rule | [#7](https://github.com/Hafeok/writ/issues/7) | #6; SHACL part on Varve #13 | |
| `land`, the only write path | [#8](https://github.com/Hafeok/writ/issues/8) | #7, #4 | |
| MCP server over stdio | [#9](https://github.com/Hafeok/writ/issues/9) | #8 | |
| Proposer | [#10](https://github.com/Hafeok/writ/issues/10) | #9, #5 | |
| `apply` | [#11](https://github.com/Hafeok/writ/issues/11) | #7 | |
| Standalone host: `serve`, inbox, remote gate, view | [#12](https://github.com/Hafeok/writ/issues/12) | #8, #9, #11 | |
| Fixtures, export and import | [#13](https://github.com/Hafeok/writ/issues/13) | #7, #5 | |
| Roslyn projector and realisation | [#14](https://github.com/Hafeok/writ/issues/14) | #7; the analyzers' two-mode release | |
| 1.0 definition | [#15](https://github.com/Hafeok/writ/issues/15) | all above | |

Parallelism: #5 can run beside #4; #11 and #13 can run beside #8 to #10;
#14 waits on the analyzers repository and can run beside anything after #7.
Whichever of two parallel sessions lands second merges `main` and reconciles.

After 1.0, and not before: fleet (Varve's management plane; Writ adds
nothing), Sigstore and eIDAS behind the `Signer` seam, the action grammar,
a browser-hosted as-of view.

## Bootstrap — #1

The definition (Draft 1), ADRs 0001–0010 with their decision sets, the build
and dependency policy, `AGENTS.md`, this file. No `src/`, no gates.

## Gates and the ruleset — #4

**Why.** ADR 0008 makes the maintainer the gate until the gates exist, and
nothing in `src/` should be written under rules nothing checks.

**Scope.** `eng/ci.cs` and the gates ported from Varve and reduced to what
Writ has (`issue-refs`, `dco`, `identities`, `dependency-register`,
`decision-sets`, `licence-headers`, `native-assets`, `package-metadata`);
`ci.yml` on Linux and Windows; the `agent review` job and the gates App; the
ruleset on `main`; `eng/land.cs`; the publishing and versioning ADR;
`releases/`, `eng/release.cs`, `eng/changelog.cs`, `eng/status.cs`.

**Gate.** `eng/ci.cs` green on an empty solution and red on each class of
violation it exists for; the ruleset refuses a push to `main` that is not a
fast-forward from a `land/` branch.

## Vocabulary and protocol — #5

**Why.** The vocabulary is the product and the protocol signs its terms;
hard constraint 7 forbids any implementation before both have a page and a
suite.

**Scope.** `docs/spec/vocabulary.md` with every `writ:` term, its invariants,
a version field and the Turtle served at the IRI; `docs/spec/protocol.md`,
the ledger's page rewritten against the vocabulary with derived acceptance
stated; the ledger's conformance fixtures carried over and extended; SHACL
shapes for both; the blend question (Q2) decided from the Varve spike and
recorded either way; the domain serving the IRI.

**Gate.** Every fixture is machine-checked against the shapes with no Writ
code beyond a Varve dataset; the IRI resolves to the page and the Turtle, and
the Turtle is byte-identical to `docs/spec/`.

## Property suite and the first projects — #6

**Why.** G1 to G10 are the specification; written before the engine, against
an in-memory store, so the engine is built to pass them.

**Scope.** The layering ADR and the first `src/` projects; the vocabulary as
a C# package; the five contracts as interfaces over the vocabulary; the
in-memory store; the engine's core (in force at a position, derived
acceptance, levels, verdicts with provenance, explain); generators and one
property per guarantee; `Writ.slnx`; API baselines.

**Gate.** All ten properties pass over the in-memory store; every project is
AOT-compatible and packable; G3's property includes an agent signer and
asserts the refusal is recorded.

## First slice — #7

**Why.** The first end-to-end verdict over a real repository, and the point
where Writ starts governing itself.

**Scope.** `docs/spec/code-facts.md` with its suite; the C# file projector;
the store contract over Varve, the embedded log in this repository; the layer
rule as SPARQL `CONSTRUCT` with its violation shape, and as SHACL if
`Varve.Shacl` exists (Q1, decided by the maintainer before this milestone);
`check`, `diff`, `explain`; `writ import` of `docs/decisions/` so Writ's own
ADRs are in Writ's own ledger; the first realisations.

**Gate.** `writ check` over this repository at head is clean; a fixture with
an upward reference is refused with rule and acceptance named; G1, G6, G7, G8
pass over the Varve store; `diff` lists the ADR imported between two
positions.

## `land` — #8

**Why.** G5 and hard constraint 6; until `land` exists Writ checks but does
not gate.

**Scope.** The two trailers; the minimum-position rule; `writ land` and its
recorded refusals; the required status check; the landing commit in the
code-fact graph; this repository gated by its own `land`, with the ADR that
supersedes ADR 0008's interim rule.

**Gate.** G5 and G6 over the Varve store; a stale position refused and the
refusal replayed; the status check red without trailers; the first commit
landed by `writ land` here is the one that turns the gate on.

## MCP server — #9

**Why.** The agent's only surface; G3 enforced at the tool boundary.

**Scope.** The server in the one binary over stdio, the verbs minus `accept`
and `review`, a test that fails if either appears, agent-to-human mapping on
every call, problem responses stating the position.

**Gate.** A reference client drives every tool; the tool list is exact; a
call to `accept` by name is refused and logged with the agent as cause.

## Proposer — #10

**Why.** Text in, a structured proposal out, never in force by itself; the
least important part and the one that must stay swappable.

**Scope.** The contract and its scripted double; `propose` over the double;
G4 refusing a level that does not exceed its inputs'; the first model-backed
proposer (Azure AI Foundry, OIDC) behind the same contract; `review` and
`accept` in the CLI with SSH signatures.

**Gate.** Every proposal property runs over the double; a corpus of Varve's
ADR drafts proposes to valid shapes; an accepted proposal is in force from its
position and `explain` shows the chain.

## `apply` — #11

**Why.** Declarations and the log must not drift; G9.

**Scope.** `apply --plan` and `apply` by a canonical diff committed
conditionally on the owned graphs' versions; stale plans refused; disjoint
applies never conflicting.

**Gate.** G9 over the Varve store.

## Standalone host — #12

**Why.** Acceptance from anywhere, a gate a runner reaches with a token, and
agents on cloud runners.

**Scope.** `writ serve`, the inbox, the remote gate, MCP over HTTP, the as-of
view, OIDC and workload identity only, `Writ-Min-Position`, every response
stating its position, the `Signer` seam proven by a second implementation.

**Gate.** Every verb gives the same result embedded and through `serve`; the
remote gate refuses what `land` refuses; auth tested against an issuer in the
test and a real one in CI.

## Fixtures, export and import — #13

**Why.** G10, and the migration path after which the legacy ledger tool is
retired (ADR 0004).

**Scope.** `docs/spec/fixtures.md` with its suite; `export` and `import` of
fixtures; `import` of legacy stores passing the ledger's suite; golden files
for every released format version.

**Gate.** G10; every legacy fixture imports and re-exports to the same
canonical bytes; the legacy tool retired.

## Roslyn projector and realisation — #14

**Why.** The second provenance, closing the gaps the file projector reports
(G8).

**Scope.** The Roslyn projector in the analyzers' second mode, coordinated
through that repository; compiler-only facts; the realisation for every
attribute the analyzers define; the analyzers' own rules as decisions
checked by Writ.

**Gate.** Both modes agree where the file projector suffices; the compiler
mode closes every gap reported on Varve; G8 with both provenances.

## 1.0 definition — #15

The four formats at version 1 under read-forever with public, passing
suites; G1 to G10 over both stores, the suite public; one binary, embedded
and standalone; MCP, proposer, `apply`, `land`, `export`/`import`; this
repository governed by its own `land` with its ADRs in its own ledger; the
legacy ledger retired; the analyzers in both modes; a Context& architecture
package (Varve's layering as decisions) checked by Writ over Varve as the
reference customer, in CI against Varve's `main`.

## Open questions

Each has an owner and the milestone that must decide it.

1. **SHACL.** Varve has no SHACL at this commit (ADR 0006). Owner: the
   maintainer. Due: before #7.
2. **Blends.** Decided by the Varve blend spike; the vocabulary keeps the
   terms either way. Due: #5.
3. **Action grammar.** Additive; after 1.0.
4. **The IRI's home page and the EU trademark search** (ADRs 0002, 0007).
   Owner: the maintainer. Due: #5.
5. **Publishing and versioning.** Due: #4.
