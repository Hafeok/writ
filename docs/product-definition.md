# Writ: product definition

Draft 1, 2026-10-18. Written outside-in: the promise first, the implementation last. Chapters 1 to 6 are the product; chapter 7 is how it happens to be built today and may change without the product changing.

A writ is a written order from an authority that commands or forbids a specific act. In this product, an accepted decision is a writ: it states what may be done, who accepted it, and from which position it is in force.

## 1. The promise

No change lands that the decisions in force at a stated position do not permit. Every decision is accepted by a named human. Every verdict is reproducible from the position alone.

Three consequences follow and are the whole product:

- An agent may propose decisions and may submit changes. It may not accept a decision, and it may not land a change by any other route.
- A decision is never applied as context. It is applied as a gate the writer cannot pass without it.
- "What was allowed when this landed" has one exact answer, read from the landed commit itself.

Everything below is how.

## 2. Who it is for

A team that lets agents write code and wants its architecture decisions enforced rather than suggested. Four roles, four surfaces; nobody edits a rule in a running system by hand.

| Role | Does | Through |
|---|---|---|
| Architect | declares spaces and rules, reviews proposals, accepts or rejects them, applies declarations | the CLI and a review inbox |
| Agent | proposes decisions from text, submits changes against a position | an MCP server, its only write path |
| CI | projects code facts, checks a change at its stated position, lands it | a required status check and the `land` command |
| Auditor | asks which decisions were in force at a position, and who accepted them | a read-only as-of view |

The architect's day: a draft ADR or a pull request arrives; the agent has turned it into a proposed rule; the architect reads the rule and its examples, signs or rejects with a reason; CI picks the new position up on the next change. The agent's day: it writes code, submits, is refused with the rule and the acceptance that made it binding, revises, submits again. Neither ever sees a rule they cannot trace to a signature.

## 3. The surface

### Commands

The CLI and the MCP tool set are the same verbs. The MCP set omits `accept` and `review`, because an agent identity can never produce an acceptance (chapter 5, G3).

| Verb | What it does |
|---|---|
| `propose <text\|file>` | turns a draft decision into a structured proposal (a space, a rule, or an enumerated decision) and records it as proposed at level max(inputs)+1 |
| `review <decision> --reason` | a signed rejection or request for change; stays in the log |
| `accept <decision> --key` | a signed acceptance; the decision is in force from this position |
| `check [--as-of <p>]` | runs every decision in force at p over the code facts at p and prints each verdict with the rule and acceptance that decided it |
| `diff <p> <q>` | what changed between two positions: code facts, rules, acceptances |
| `land <change>` | the only route by which a change reaches the repository (below) |
| `apply --plan` / `apply` | converges declaration files in the repository with the decision log: a canonical diff committed conditionally on the owned graphs |
| `explain <verdict\|decision>` | the derivation: inputs, rule, emergent constraints, acceptances, positions |
| `export` / `import` | a position-pinned, pseudonymised slice of the log as a replayable fixture |

### `land`

A change is a patch plus the position it was written against. `land` refuses it unless:

1. the commit message carries `Decisions-Position: <p>` and `Decisions-Head: <header hash at p>`;
2. p is not behind the latest position at which any decision touching a changed file was accepted, superseded or revoked (the minimum-position rule);
3. `check` at p over the projected result is clean.

A refusal names which of the three failed and is written to the log with the agent as cause. On success, the landing commit carries the trailers, and the code-fact graph gains one commit whose cause is that git SHA. There is no other write path: an agent has no push, only `land`.

### Git and CI conventions

- Two commit trailers, `Decisions-Position` and `Decisions-Head`, on every landed commit.
- One required status check, which verifies the trailers against the log and re-runs `check` at the stated position.
- Problem responses state the position they were evaluated against, so a refusal can become a fixture.

### The as-of view

A read-only page per repository: the decisions in force at a position, who accepted each and when, the verdicts at that position, and the diff to any other position. It reads the same log the CLI writes and adds nothing.

## 4. The formats

Every format is a specification page with a conformance suite before any implementation. Formats are under a read-forever rule from the first release: anything Writ has ever written stays readable.

### The decision vocabulary (`writ:`)

One vocabulary, minted at a stable IRI, covering:

- **Spaces.** A decision seen as a frame: slots (roles such as `layerOf`, `references`, `clock`), each with a type.
- **Rules.** A composition of two spaces: a mapping between their slots, and a template for the resulting blend. A rule is written as a query (SPARQL `CONSTRUCT` or `sh:rule`) and carries its violation shape.
- **Blends.** A decision produced by a rule from two inputs. A blend records its inputs, its rule and the position it was derived at, and inherits acceptance through them.
- **Emergent constraints.** A constraint present in a blend and absent from both inputs. Always computed by a check, never typed in.
- **Levels.** Every space, rule and blend has an integer level; a blend's level strictly exceeds the maximum of its inputs. The derivation graph is therefore acyclic, and no decision is its own premise. (Supersession is temporal; level is derivational; both exist.)
- **Mappings and realisations.** A mapping relates slots across spaces. A realisation relates a decision to the code shape a projector recognises in one language. A second language is a second realisation, not a second ontology.
- **Enumerated decisions.** A decision no rule produces. Expressible as a node, accepted directly, checked by its own shape.

Whether rules with emergent constraints earn their place is an open question decided by evidence (the Varve blend spike of 2026-10-18 is the first test). The vocabulary keeps both: if no accepted domain ever needs a blend, rules reduce to shapes and the terms stay unused.

### Acceptance and authority (the ledger)

The ledger protocol is merged into Writ as its acceptance and signature layer: decisions and versions, `supersedes`, acceptances that sign one version hash, reviews, grants with primary and fallback holders, filed unavailability, and agent attribution (an agent identity mapped to the human responsible for it). Signatures are plain SSH signatures in the open engine; a heavier scheme (Sigstore, eIDAS) is a pluggable seam, not a requirement.

Derived acceptance is the one addition the ledger needs: a blend has no acceptance of its own and is in force at p iff its rule and every input version have a live acceptance at p. This is stated in the protocol, not left to implementations.

### Code facts

Per language, a projection of the repository into a graph: packages and their declared layers, references, visibility, public API baselines, decision citations on code elements. The projector's contract is "repository at commit → quads", with the facts a file-only projector can supply distinguished from those that need a compiler, so a verdict can say which it relied on.

### Fixtures

A position-pinned slice of the log, pseudonymised, replayable in a test. The format reuses the decision vocabulary and the log's own delta format; it adds a manifest and nothing else.

## 5. The guarantees

The gate is the specification. Each guarantee is a property test over generated decision histories, code histories and acceptance schedules, and the suite is public.

- **G1. Determinism.** A verdict at p is a pure function of the log up to p. The same log gives the same verdict on every platform and every run.
- **G2. Acceptance chain.** No decision applies at p without a live acceptance chain at p: its own, or (for a blend) its rule's and every input's.
- **G3. Agents never accept.** An agent identity cannot produce an acceptance or a review under any input. The attempt is refused and recorded.
- **G4. Acyclic derivation.** Every blend's level exceeds its inputs'. A proposal that would violate this is refused at `propose`.
- **G5. No stale landing.** `land` refuses a change whose stated position is behind the minimum position for the files it touches.
- **G6. Replay.** Replaying any landed history reproduces every verdict ever given, and every refusal.
- **G7. Explainability.** Every verdict decomposes into inputs, rule, emergent constraints and acceptances, each with a position; `explain` never says "unknown".
- **G8. Projector honesty.** A verdict names the facts it relied on and whether each came from files or from a compiler; a fact the projector could not supply is reported as a gap, never assumed.
- **G9. Idempotent apply.** Applying declarations twice gives the second plan empty; a stale saved plan is refused; disjoint applies never conflict.
- **G10. Pseudonymised export.** No redacted term appears in any byte of a fixture; replaying a fixture reproduces the boundary-restricted state at every step.

A Context& architecture package is a set of accepted decisions under this vocabulary; what a customer buys is G1 to G10 holding over their own code against those decisions.

## 6. The contracts between parts

Five interfaces, each small, each expressed over the vocabulary. The product is the vocabulary plus these; everything else is replaceable.

| Contract | In | Out | First implementation |
|---|---|---|---|
| **Projector** | repository at a commit | code-fact quads, with provenance (file or compiler) | C# from project files; C# from Roslyn |
| **Realisation** | a decision | the code shape that satisfies or violates it in one language | C#: `[DesignDecision]`, `[Contract]`, layer properties |
| **Proposer** | text (ADR draft, PR description, diff) | a structured proposal in the vocabulary, via one tool call | a tool-calling model; a scripted double for tests |
| **Signer** | a decision version, a key | an acceptance or review | SSH signatures |
| **Store** | commits over the three graphs | positions, as-of reads, diffs, conditional commits | an embedded event-sourced RDF store |

The C# analyzers run in two modes behind the same packages: rules in Roslyn (today's enumerated decisions, no graph required) or rules in the graph with Roslyn reduced to projector and realisation. A team can start in the first and move to the second without changing its decisions.

## 7. Implementation (today)

This chapter may change without chapters 1 to 6 changing.

| Part | Built from | Why this and not another |
|---|---|---|
| Store | Varve, embedded, file backend kept in Git | positions, as-of reads, `DiffAsync`, per-graph conditional commits and a header chain are the promise; no other store has them as a model rather than a feature |
| Acceptance | ledger-core (from product-cli), merged into this repository | the protocol is Writ's signature format; one repository for one promise |
| C# projector and realisation | DecisionDriven.Analyzers, kept public and thin, both modes | Roslyn packaging has its own cadence |
| Proposer | any tool-calling model; Azure AI Foundry first | the proposer is the least important part and must stay swappable |
| Shapes and rules | SHACL and SPARQL `CONSTRUCT`, evaluated by Varve | standard languages, no proprietary rule language |
| Hosts | one binary: CLI, `serve`, MCP over stdio or HTTP, the CI gate, the as-of view | see 7.1 |

### 7.1 Hosts

The same binary runs in three ways over the same embedded store. Nothing in chapters 1 to 6 depends on which.

**Embedded.** `writ` in a repository: the log is a Varve file-backend dataset kept in Git (`derived/` ignored and rebuilt), the CLI is the writer, CI runs `check` and `land` from a checkout. No server, no network, no token. This is the single-repository case and the default.

**Standalone (`writ serve`).** The binary started as a server over one dataset, which it alone writes; CLIs pointed at it commit through it, never beside it. It exists for what embedded cannot do:

- the inbox: proposals from any repository, acceptance by an architect from anywhere, asynchronously, with the signature returned to the log;
- the remote gate: CI posts a change and its position; the server projects, checks and answers with the verdict and the position it evaluated at, so a runner needs a token and nothing else;
- MCP over HTTP for agents on cloud runners, with the same tool set and the same omission of `accept`;
- the as-of view;
- the signing seam, where a heavier scheme than SSH (Sigstore, eIDAS) plugs in behind the `Signer` contract for a hosted service.

Rules carried from Varve: OIDC and workload identity only, no API keys; a client that needs a revocation in force sends `Writ-Min-Position` and gets `503` with the server's position until it has caught up; every response states the position it was evaluated at.

**Fleet.** Several servers over one object store take a single writer and tier-1 followers from Varve's management plane. Writ adds nothing for this; it is a later milestone that costs the store contract no change.

Order of work: the vocabulary and the protocol page with their conformance suites; the property suite for G1 to G10 against an in-memory store; the C# file projector and the layer rule as the first end-to-end slice; `land` with the trailers and the status check; the MCP server; the proposer; `apply`; the as-of view; `export`/`import`.

## 8. Boundaries and decisions taken

- **Name.** Writ. Warrant was the first choice and was dropped on 2026-10-18: `warrant-dev` is an active Apache-2.0 authorization service with a `warrant` CLI and `warrant.dev`. "Warrant" survives inside Writ as the term for what an acceptance confers on a decision at a position.
- **Licence.** Apache-2.0. The engine is open; Context& architecture packages are content on it.
- **Repositories.** One new repository for Writ: vocabulary, protocol, suite, CLI, server, MCP, gate, view, and the merged ledger. The analyzers stay in their public repository. Varve stays in its own; Writ is an embedded consumer and puts nothing Writ-specific into it.
- **Language.** The whole repository is .NET and C#. The ledger is rewritten, not ported: the protocol page and its conformance fixtures carry over, the code does not. `writ import` reads today's ledger stores so existing `.decisions/` directories migrate, and the existing tool is retired once the C# implementation passes the same suite. The `dec` orchestrator is a separate tool and stays out.
- **Not in scope.** A latent planner, reinforcement learning, or any learned model inside the gate. Writ's "learning" is a proposer feeding a human-accepted log, and it is auditable precisely because nothing learned sits between a decision and a verdict.
- **Open, decided by evidence.** Whether blends with emergent constraints are needed (the Varve spike); whether the action grammar (chapter 6, realisation) can generate code from accepted decisions rather than only check it. Both are additive to this definition.

## Appendix: name availability (checked 2026-10-18)

- NuGet: no `Writ` or `Writ.*` package.
- GitHub: `writ` is an inactive personal account with no repositories; an organisation needs another handle (`writ-dev`, or the product under an existing owner).
- npm: `writ` exists as a small literate-programming tool; Writ ships no npm package, so there is no conflict in use, only in search.
- `writ.dev` resolves to something and refuses automated fetching; check by hand before relying on it.
- EU trademark: not checked.
