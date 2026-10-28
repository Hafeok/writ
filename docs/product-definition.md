# Writ: product definition

Draft 2, 2026-10-20 (Draft 1: 2026-10-18). Written outside-in: the promise first, the implementation last. Chapters 1 to 6 are the product; chapter 7 is how it happens to be built today and may change without the product changing.

A writ is a written order from an authority that commands or forbids a specific act. In this product, an accepted decision is a writ: it states what may be done, who accepted it, and from which position it is in force.

> **Changes in Draft 2** (each marked `[D2]` in place):
> 1. Chapter 1: the thesis sentence, and the log as a store for any positioned graph with `writ:` as the governance vocabulary and `pf:` (the Product Framework What/How graph) as the first guest.
> 2. Chapter 3: `land` generalised from code to any owned graph; `check` gains a third outcome, the open question.
> 3. Chapter 4: the named graphs; acceptance under grant (scope); the baseline on an acceptance; guest vocabularies.
> 4. Chapter 5: G2 restated under grant; G8 enumerates provenance kinds; G11 (the baseline ratchet) added.
> 5. Chapter 6: the Store contract admits guest vocabularies; the Projector contract admits non-code reporters.
> 6. Chapter 8: decisions taken on 2026-10-20.
> 7. (2026-10-21) Chapter 3: the open question's fields (`blocks`, `candidates`, `answeredBy`); Chapter 4: scope as named graphs with SHACL targets, evaluated at signing, grants as decisions.
> 8. `[D2.1]` (2026-10-21) Chapter 3: five profiles, verbs not configuration; Chapter 6: contracts are modules, two mandatory, configuration is a decision or does not exist; Chapter 7.1: assemblies per contract, the decision engine alone as a build property.
> 9. `[D2.2]` (2026-10-21) Chapter 3: the MCP section (placement on the writer, tools, resources, no projector, identity, concurrency) and sessions (a PROV activity in the log; the connection as server state and telemetry; reconnection by re-proven identity). Chapter 4: sessions in the decision graph.
> 10. `[D2.3]` (2026-10-21) The clock is a header fact stamped by the writer; the engine reads no other. Fixtures replay as recorded (G6) or live through a test clock. G1 and the Store contract amended.
> 10a. `[D2.4]` (2026-10-21) Chapter 8: product-cli's scope is the What alone; the How, seams, delivery and every signature live in Writ.
> 11. `[D2.5]` (2026-10-21) Chapter 4: two conformance classes of the protocol, provenance and authority; a landed graph delta records its source log, position, session and agent as PROV.
> 12. `[D2.6]` (2026-10-21) Chapter 4: provenance of decisions across logs by pinned version and position; force stays local; `check` reads one log; `explain` and `import` cross. G7 and `import` amended.
> 13. `[D2.7]` (2026-10-21) Chapter 1: the promise across systems and its honest limit; G10: cross-log references in fixtures, vendor namespaces in clear.
> 14. `[D2.8]` (2026-10-28) Realisation renamed Binding and narrowed to the How's kind 2 (a What element to a shape in a target); constraints evaluate over projector facts, contracts over reporter facts. G8 gains `deployment-declared` and `deployment-observed`. Follows the How rulings of 2026-10-28 in decision-driven-design.
> 15. `[D2.9]` (2026-10-28) Chapter 7: the shipped binary binds the scripted Proposer double; the model-backed Proposer lives in Bailiff (its definition, 2026-10-21). Chapter 4 and 6 prose: 'realisation' retired as a term; 'realises' remains a verb.

## 1. The promise

No change lands that the decisions in force at a stated position do not permit. Every decision is accepted by a named human. Every verdict is reproducible from the position alone.

Three consequences follow and are the whole product:

- An agent may propose decisions and may submit changes. It may not accept a decision, and it may not land a change by any other route.
- A decision is never applied as context. It is applied as a gate the writer cannot pass without it.
- "What was allowed when this landed" has one exact answer, read from the landed commit itself.

`[D2]` **Writ is the signed boundary between reasoning and execution.** A position is a frozen, signed context: what was decided, by whom, over which specification, against which facts. Reasoning (a proposer, which may be a large model, or a human) writes *into* the log through `propose`; execution (a builder, which may be a small model, or a human) writes *against* a position and is refused by `land` when it steps outside it; `explain` replays the derivation with no model in it. Nothing learned sits between a decision and a verdict, so the explanation of why a change was permitted is a query over the log, never a model's recollection of itself.

`[D2.7]` The promise extends across systems. Decisions reference the decisions they rest on by pinned version across logs, so from any outcome (a refusal, a landed commit, a What-version) the chain of who decided what, and why, is walkable back through every log it crosses, as far as the logs keep the protocol. Where the chain reaches a system that keeps no log, `explain` says so at that edge, which is the honest limit and is itself an answer. This is the pattern Writ exists to demonstrate for any system in which an AI acts: not only "what was allowed here" but "what was allowed here, resting on what, decided by whom, back to the beginning". The decision-driven-design repository shows the pattern; Writ is its reference implementation; a Context& package is the pattern sold.

`[D2]` The log holds positioned graphs under more than one vocabulary. `writ:` is the governance vocabulary: decisions, acceptances, verdicts. A *guest vocabulary* describes what is being governed; the first is the Product Framework's `pf:` graph, the What and the How of a software product, which Writ holds as a positioned graph and signs exactly as it signs a decision. Code is one projection of that graph, not the only one. Everything below is how.

## 2. Who it is for

A team that lets agents write code and wants its architecture decisions enforced rather than suggested. Four roles, four surfaces; nobody edits a rule in a running system by hand.

| Role | Does | Through |
|---|---|---|
| Architect | declares spaces and rules, reviews proposals, accepts or rejects them within the scope of a grant, applies declarations | the CLI and a review inbox |
| Agent | proposes decisions from text, submits changes against a position | an MCP server, its only write path |
| CI | projects code facts, checks a change at its stated position, lands it | a required status check and the `land` command |
| Auditor | asks which decisions were in force at a position, and who accepted them | a read-only as-of view |

`[D2]` Where the log holds a `pf:` graph, a fifth role appears without a fifth surface: the product owner, who holds the grant for the What. Product-cli's split (the What owned by product and design, the How by engineering) becomes two grants over two subgraphs of the same log; the architect does not sign the What and the product owner does not sign the How.

The architect's day: a draft ADR or a pull request arrives; the agent has turned it into a proposed rule; the architect reads the rule and its examples, signs or rejects with a reason; CI picks the new position up on the next change. The agent's day: it writes code, submits, is refused with the rule and the acceptance that made it binding, revises, submits again. Neither ever sees a rule they cannot trace to a signature.

## 3. The surface

### Commands

The CLI and the MCP tool set are the same verbs. The MCP set omits the verbs that name a principal (below), because an agent identity can never produce an acceptance (chapter 5, G3).

| Verb | What it does |
|---|---|
| `propose <text\|file>` | turns a draft decision into a structured proposal (a space, a rule, or an enumerated decision) and records it as proposed at level max(inputs)+1 |
| `review <decision> --reason` | a signed rejection or request for change; stays in the log |
| `accept <decision> --key [--baseline <p>]` | a signed acceptance under the signer's grant; the decision is in force from this position, with the violations known at p tolerated as its baseline `[D2]` |
| `check [--as-of <p>]` | runs every decision in force at p over the facts at p and prints each verdict with the rule and acceptance that decided it |
| `diff <p> <q>` | what changed between two positions: facts, rules, acceptances, baselines |
| `land <change>` | the only route by which a change reaches an owned graph (below) |
| `apply --plan` / `apply` | converges declaration files in the repository with the decision log: a canonical diff committed conditionally on the owned graphs |
| `explain <verdict\|decision>` | the derivation: inputs, rule, emergent constraints, acceptances, baselines, positions |
| `export` / `import` | a position-pinned, pseudonymised slice of the log as a replayable fixture; `import` also lands a package of decisions from another log with their `basedOn` provenance, for local acceptance |

### Profiles `[D2.1]`

The binary runs as one of five profiles. A profile is a verb that fixes which contracts of chapter 6 are bound; it takes the log address and an identity and nothing else. Profiles are not configurable, and there is no sixth.

| Profile | Binds | Is |
|---|---|---|
| `writ` | all five, locally | the embedded, single-repository case; the default |
| `writ serve` | Store (as the single writer), Signer; Projector, Binding and Proposer only if the log's decisions name editions it carries | the decision server; alone, it is the decision engine with no code in it |
| `writ gate` | Projector, Binding; Store and Signer as a client of a `serve` | the CI runner: `check` and `land` for one repository against a remote log |
| `writ mcp` | Proposer; Store and Signer as a client; never a Projector | the agent surface, over stdio or HTTP (below) |
| `writ view` | Store as a read-only client | the as-of page |

Every profile except `writ` is a client of exactly one `serve`, and there is one writer per log: a client never commits beside the server, only through it. Position is therefore global across profiles, and every answer a profile gives states the position it was evaluated at. Two profiles against two logs are two products; Writ does not federate writes or verdicts across logs. Decisions reference decisions in other logs by pinned version and position (chapter 4), and `explain` follows them.

### MCP `[D2.2]`

**Where it sits.** `writ mcp --log <url>` is a client of a `serve`. `writ mcp --log <path>` opens the file backend and is the writer for as long as it holds the lock: the embedded, single-agent case, with nothing else committing meanwhile. Two or more clients therefore require a `serve`, because two processes cannot both be the writer. This is the only way several agents share one position, and it is why multi-client is a server property rather than a feature.

**Tools.** `propose` (text or structured), `check --as-of`, `diff`, `explain`, `land` (submit a change with its position; the server's gate, or a `gate` it delegates to, projects and checks), `apply --plan` (read-only). Not exposed: `accept`, `review`, grant, waiver (each names a principal, G3); `apply` (writes declarations as the architect); `export` and `import` (the auditor's and migration's). There is no tool that writes quads to a named graph; every write is a verb with a gate.

**Resources.** The current position; the decisions in force at p; the verdicts at p; open questions and what they block; baselines and their size; a guest-graph subgraph at p (a `pf:` flow, Decider or system, by IRI); the vocabulary editions in force; `explain` for any verdict or decision. All reads take a position and default to the session's acknowledged position, never to the head, so a builder working against p sees p.

**Projector.** `writ mcp` binds none. An agent's `check` is the server's `check`, so an agent cannot evaluate against a projector edition the log did not name.

**Identity.** Every MCP client is an agent identity (OIDC or workload identity, attributed to a human in the authority graph). `propose` and `land` record it as cause. Two clients against one server are two identities.

**Concurrency.** Two sessions landing against the same p with disjoint elements both succeed, in order of arrival. With overlapping elements the second is refused by G5 and resubmits against the new position. The server never merges.

### Sessions `[D2.2]`

A session has two halves with different lifetimes, and only one is in the log.

**The session is a PROV activity in the log.** Opened by an identity at a position; closed at a position; every `propose` and `land` from it cites it (`prov:wasAssociatedWith`). It is written into the decision graph, because agents may write there, and never into the authority graph. It is durable because chapter 1 depends on it: `explain` runs from a landing back to the session that built it and from a proposal back to the session that reasoned it, and the two are distinct activities, usually with distinct identities. One identity may hold several sessions; a session never changes identity. The same record shape as Varve's agent session, under `writ:`.

**The connection is server state.** Which sessions are connected now, over which transport, and how far behind the head each is reading expire on their own and are not log facts. `serve` holds them and exports them as OpenTelemetry: a gauge of open sessions per identity, a histogram of position lag, a span per verb carrying the position evaluated at and the session. The as-of view shows sessions open at p from the log; the live count comes from metrics; the two differ by design.

**Reconnecting.** The transport's session id (`Mcp-Session-Id` for Streamable HTTP) is a correlation handle, not a credential. The server resumes a session only when the identity re-proven by OIDC or workload identity matches the one that opened it, and resumes at the session's last acknowledged position, so a reconnecting builder learns at once whether its position is stale. A session no identity has re-proven within its lease is closed at the server's current position, and the close is written to the log like any other.

### `land`

`[D2]` A change is a delta to one owned graph plus the position it was written against. For code the delta is a patch and the graph is the code-fact graph through its projector; for a guest vocabulary the delta is a set of quads in that vocabulary. `land` refuses a change unless:

1. the change states its position: for code, the commit message carries `Decisions-Position: <p>` and `Decisions-Head: <header hash at p>`; for a graph delta, the commit envelope carries the same two fields;
2. p is not behind the latest position at which any decision touching the changed elements was accepted, superseded or revoked (the minimum-position rule);
3. `check` at p over the projected result is clean, where clean means: no violation outside the baselines in force, and no open question that blocks this graph.

A refusal names which of the three failed and is written to the log with the agent as cause. On success, the landing commit carries the trailers, and the owned graph gains one commit whose cause is that git SHA (for code) or the signed envelope (for a graph delta). A landing may shrink a baseline, never grow it (chapter 5, G11). There is no other write path: an agent has no push, only `land`.

### `check` outcomes `[D2]`

A verdict is one of three, never a boolean:

- **clean**: every decision in force holds, or its violations are within its baseline;
- **violation**: a decision in force does not hold outside its baseline; names the rule, the acceptance, and the facts relied on;
- **open question**: a decision in force fails in a way the log cannot attribute to the facts or to the decision. The canonical case is data conformance in `pf:` (§3.1 of the Product Framework): production data violates a declared shape, and either the data is wrong or the specification is stale. An open question fails nothing by itself; it is a finding that demands a new act. `land` into a blocked graph is refused until the question is answered by an accepted decision or a signed waiver.

An open question is a node in `derived/` (it is a valuation, so it is never committed), identified by the decision IRI and the fact IRIs it could not attribute, so the same question at two positions is the same node. It carries:

- `blocks`: a set drawn from the named graphs of chapter 4 (`decision`, a guest graph by name, `code`), possibly empty. The blocked set is declared on the decision, not chosen per question: a decision states which graphs its open questions block, and the default is the graph the decision's rule ranges over. An empty set is a reported question that stops nothing.
- `candidates`: exactly two, each a graph and the element in it that would have to change (for data conformance: the report, or the `pf:` shape). `explain` prints both; `check` never picks one.
- `answeredBy`: absent while open; otherwise the decision or waiver that closed it, with its position. A question is closed at p iff its answer is live at p, so an expired waiver reopens it.

`land` refuses a change into a graph in `blocks` of any open question at the change's position, naming the question. A change into an unblocked graph lands and the question persists.

### Git and CI conventions

- Two commit trailers, `Decisions-Position` and `Decisions-Head`, on every landed commit.
- One required status check, which verifies the trailers against the log and re-runs `check` at the stated position.
- Problem responses state the position they were evaluated against, so a refusal can become a fixture.

### The as-of view

A read-only page per repository: the decisions in force at a position, who accepted each and when, the verdicts at that position, the baselines and their size, and the diff to any other position. It reads the same log the CLI writes and adds nothing.

## 4. The formats

Every format is a specification page with a conformance suite before any implementation. Formats are under a read-forever rule from the first release: anything Writ has ever written stays readable.

### The named graphs `[D2]`

The log is one positioned dataset. Each position commits to some of these named graphs; who may write each is fixed by the Store contract and enforced by per-graph conditional commit, not by convention.

| Graph | Holds | Written by | Concept |
|---|---|---|---|
| vocabulary (one per edition) | the `writ:` TBox and each target vocabulary (`writ-cs:`, …), pinned by version in the header | nobody per position; read-only, replaced only by a new edition | the language |
| decision | spaces, rules, blends, mappings, bindings, enumerated decisions, violation shapes, proposals, sessions (PROV activities) | `propose`, `apply`, session open and close; agents may write here | the execution space and the verdict space, declared |
| authority | acceptances with their scope and baseline, reviews, grants, unavailability, agent attribution, waivers | `accept`, `review`; never an agent identity | what makes a decision binding |
| ground: code facts | the projection of a repository at a commit | a projector; cause is the git SHA | the ground, for code |
| ground: guest graphs (one per vocabulary) | a positioned graph under a guest vocabulary, `pf:` first | `land` with a graph delta; cause is the signed envelope | the ground for acts on the specification, and the execution space for acts on code realising it |
| reports (one per reporter kind) | facts from a non-SPARQL reporter: a behavioural-conformance runner, a data-conformance run, telemetry, an attestation | the reporter; cause names the reporter and its input hash | ground, with provenance |
| derived (not committed) | blends materialised, emergent constraints, valuations, open questions | rebuilt from the graphs above up to p; G1 | the verdict space, valued |

The verdict space is declared (the violation shapes in the decision graph) and valued (the answers in `derived/`). Only the declaration is in the log; the valuation is a function of it.

### The decision vocabulary (`writ:`)

One vocabulary, minted at a stable IRI, covering:

- **Spaces.** A decision seen as a frame: slots (roles such as `layerOf`, `references`, `clock`), each with a type.
- **Rules.** A composition of two spaces: a mapping between their slots, and a template for the resulting blend. A rule is written as a query (SPARQL `CONSTRUCT` or `sh:rule`) and carries its violation shape.
- **Blends.** A decision produced by a rule from two inputs. A blend records its inputs, its rule and the position it was derived at, and inherits acceptance through them.
- **Emergent constraints.** A constraint present in a blend and absent from both inputs. Always computed by a check, never typed in. Concretely: a shape present in the blend's violation shape and in neither input's.
- **Levels.** Every space, rule and blend has an integer level; a blend's level strictly exceeds the maximum of its inputs. The derivation graph is therefore acyclic, and no decision is its own premise. (Supersession is temporal; level is derivational; both exist.)
- **Mappings and bindings.** A mapping relates slots across spaces. A binding relates a What element to the shape that realises it in one target (the How's kind 2; `[D2.8]` the word is the How vocabulary's, and `writ:realisation` is never minted). A constraint needs no binding: it evaluates over a projector's facts, and the citation attributes a projector recognises are part of its fact vocabulary. A contract needs none either: it evaluates over a reporter's facts. `[D2]` A target is a language (C#, where the shape is a code shape) or a guest vocabulary (`pf:`, where the realisation is the subgraph shape, for instance a `pf:Decider` to the pure core the application contract demands). A second target is a second binding vocabulary, not a second ontology.
- **Enumerated decisions.** A decision no rule produces. Expressible as a node, accepted directly, checked by its own shape.

Whether rules with emergent constraints earn their place is an open question decided by evidence (the Varve blend spike of 2026-10-18 is the first test). The vocabulary keeps both: if no accepted domain ever needs a blend, rules reduce to shapes and the terms stay unused.

### Guest vocabularies `[D2]`

A guest vocabulary is a TBox Writ does not own, pinned by edition like its own, whose instances live in a ground graph of their own and are governed by `writ:` decisions over them. The first is `pf:` (the Product Framework core ontology). Three rules keep Writ from absorbing the guest:

- Writ never extends a guest vocabulary. What a guest cannot say is a decision in `writ:` about guest nodes, not a new guest term.
- A guest graph's own conformance rules (for `pf:`, the structural kinds of §6.3: layout, coherence, domain, seam, journey, state and Decider justification) are imported as enumerated decisions with their shapes, proposed and accepted like any other. They are not built in.
- Bindings relate guest nodes to code shapes, so a check at p can hold code against the specification at p. `realises_version` (Product Framework §7.3) is then a verdict over two graphs at one position, not a stamp.

### Acceptance and authority (the ledger)

The ledger protocol is merged into Writ as its acceptance and signature layer: decisions and versions, `supersedes`, acceptances that sign one version hash, reviews, grants with primary and fallback holders, filed unavailability, and agent attribution (an agent identity mapped to the human responsible for it). Signatures are plain SSH signatures in the open engine; a heavier scheme (Sigstore, eIDAS) is a pluggable seam, not a requirement.

`[D2.5]` **Two conformance classes.** The protocol page defines two, and a log claims one or both:

- *Provenance-conformant*: a positioned log whose every commit is a `prov:Activity` with a `prov:Agent` in the protocol's identity scheme, whose header carries the writer's clock and is covered by the header hash, whose sessions are PROV activities, and whose content hashes follow the canonical hash law. Any Varve log can be this; product-cli's draft log is.
- *Authority-conformant*: a provenance-conformant log that also carries grants, scopes, acceptances, reviews and waivers under G2 and G3. Only a Writ log is this.

A graph delta landed from a provenance-conformant log carries, in its envelope, the source log's identity, the source position and header hash, the session IRI and the agent. `land` records them as `prov:wasDerivedFrom` and `prov:wasAssociatedWith` on the resulting commit, so `explain` walks from a Writ position into the source log's session without the source ever having known a Writ position. PROV crosses systems; authority does not.

`[D2.6]` **Provenance of decisions across logs.** A decision's IRI is minted under a namespace and is global; a version is its content hash. A decision in one log that rests on a decision in another carries `writ:basedOn <decision IRI>@<version hash>` together with the source log's identity and the position at which it was read: the hash pins what was relied on, the position locates it. The edge is `prov:wasDerivedFrom` and crosses logs; force does not. The referencing decision is in force only under an acceptance in its own log, by a holder with a grant there; a signature in the source log confers nothing here. `import` of a package from another log lands its decisions as a graph delta carrying these edges, after which they are accepted locally like any other. `check` reads only its own log (G1): the content relied on is in it. Reading across logs happens in `explain` and `import` only, which are reads and landings, never verdicts. The chain from an outcome runs: the verdicts at its position, the decisions in force, their inputs and blends, their `basedOn` edges, and the same walk in each source log at the pinned version, for as many logs as the chain crosses.

Derived acceptance is the one addition the ledger needs: a blend has no acceptance of its own and is in force at p iff its rule and every input version have a live acceptance at p. This is stated in the protocol, not left to implementations.

`[D2]` **Acceptance under grant.** A grant names a holder and a scope. An acceptance is valid only within the scope of a live grant held by its signer at that position; outside it, the acceptance is refused at `accept` and, if it reaches the log by any other route, is dead for G2. The genesis grant of a log is unscoped. Writ's own log carries at least two scopes from the day it holds a `pf:` graph: the What (`pf:` nodes of the §3 kinds) and the How and code (`pf:` nodes of the §4 kinds, the decision graph, the code facts).

A scope is a set of named graphs, each optionally narrowed by a SHACL target (`sh:targetClass`, `sh:targetNode`, `sh:targetSubjectsOf`, or a SHACL-AF target with a `sh:select` query), evaluated at the accepting position over that graph. A decision is within scope iff every node its rule or shape ranges over is in the target's focus nodes at that position; a decision that ranges over nodes in two scopes needs an acceptance under each, from the same or different holders, and is in force only when both are live (this is the same conjunction as derived acceptance for blends, applied across scopes instead of across inputs). Scope is evaluated when the acceptance is signed and the result recorded with it; a later change to the graph does not retroactively narrow or widen it, so G2 stays a function of the log and not of a re-evaluation. A grant is itself a decision: proposed, reviewed, accepted by a holder whose own grant covers the authority graph, and superseded like any other, so the chain of who-may-sign-what bottoms out in the genesis grant and nowhere else.

`[D2]` **Baseline.** An acceptance may carry a baseline: the set of violations of the accepted decision known at the accepting position, each named by stable identity (the decision IRI and the fact IRIs the projector minted, never a file and line). The decision is in force from that position; the ground converges to it. A landing that removes a baselined violation records the smaller baseline at its position with no signature; a landing that adds a violation is refused; growing a baseline requires a fresh acceptance. The gap between a decision and its baseline is the distance to the decision, and `diff p q` reports it as such. (This is the public-API baseline of Draft 1, generalised to every decision; it is also Product Framework §7.3's computed direction, with the opposite sign: there, features not yet done; here, violations not yet removed.)

`[D2]` **Waivers.** A signed answer to an open question that changes no decision: "the data is wrong, not the specification", with a reason and a review-by position. A waiver is an authority-graph record, expires, and is reported by `check` until the question is closed by a decision or the data.

### Code facts

Per language, a projection of the repository into a graph: packages and their declared layers, references, visibility, public API baselines, decision citations on code elements. The projector's contract is "repository at commit → quads", with the facts a file-only projector can supply distinguished from those that need a compiler, so a verdict can say which it relied on. `[D2]` Fact IRIs are stable across commits for the same element; a renamed element is reported as a rename, not a removal and an addition, so baselines survive refactoring.

### Reports `[D2]`

A reporter is a projector whose input is not a repository: a behavioural-conformance runner (Product Framework §6.3.1, stdin/stdout), a data-conformance run over a production oracle, a telemetry window for a runtime bound, a human attestation for a manual criterion. Its contract is "input hash → quads, with provenance", and its quads land in the reports graph with the reporter named as cause. A verdict that relies on a report says so (G8). Nothing in a report is a verdict; verdicts are SPARQL and SHACL over the log, and a report is evidence they range over.

### Fixtures

A position-pinned slice of the log, pseudonymised, replayable in a test. The format reuses the decision vocabulary and the log's own delta format; it adds a manifest and nothing else.

`[D2.3]` **Clocks.** The engine never reads a wall clock. The only clock in the product is the one the Store's writer stamps on each commit header, and every time-dependent evaluation (a session lease closing, a waiver lapsing, a signature's validity window) reads the clock of the header at the position being evaluated. A fixture carries the header clocks, so it replays two ways: as recorded, with the original clocks, which reproduces every verdict and keeps PROV times intact; or live, re-committed through a test store whose writer stamps the test's clock, so expiries can be exercised without waiting. Live replay yields a different log with different headers; its verdicts may differ, and that is what it is for. Anything the vocabulary can express as a position rather than a date is a position (a waiver's review-by is); a lease is the exception, a duration added to a header clock and recorded as data on the close.

## 5. The guarantees

The gate is the specification. Each guarantee is a property test over generated decision histories, code histories, guest-graph histories and acceptance schedules, and the suite is public.

- **G1. Determinism.** A verdict at p is a pure function of the log up to p, including the clocks recorded in its headers; no process clock enters a verdict. The same log gives the same verdict on every platform and every run.
- **G2. Acceptance chain.** `[D2]` No decision applies at p without a live acceptance chain at p, each acceptance within the scope of a grant live at its own position: its own, or (for a blend) its rule's and every input's.
- **G3. Agents never accept.** An agent identity cannot produce an acceptance, a review, a grant or a waiver under any input. The attempt is refused and recorded.
- **G4. Acyclic derivation.** Every blend's level exceeds its inputs'. A proposal that would violate this is refused at `propose`.
- **G5. No stale landing.** `land` refuses a change whose stated position is behind the minimum position for the elements it touches, in any owned graph.
- **G6. Replay.** Replaying any landed history as recorded reproduces every verdict ever given, every refusal, every open question, and every session close at its recorded clock. Replaying it live, through a writer with another clock, is a different log and makes no such claim.
- **G7. Explainability.** Every verdict decomposes into inputs, rule, emergent constraints, acceptances, baselines and (for an open question) the two candidate causes, each with a position, and every decision into its `basedOn` chain across logs at pinned versions; `explain` never says "unknown". A source log that cannot be reached is reported as its identity, the pinned version and position, and "not reachable", which is an answer.
- **G8. Projector honesty.** `[D2]` A verdict names the facts it relied on and the provenance of each, from a closed set: `file`, `compiler`, `graph` (a guest graph), `runner`, `data`, `telemetry`, `attestation`, and `[D2.8]` `deployment-declared` (infrastructure as declared, from IaC or a manifest) and `deployment-observed` (as observed from the platform's own API). A contract's violation description says which of the two it requires. A fact no projector or reporter could supply is reported as a gap, never assumed; a verdict that would need a gap to decide is an open question, not a pass.
- **G9. Idempotent apply.** Applying declarations twice gives the second plan empty; a stale saved plan is refused; disjoint applies never conflict.
- **G10. Pseudonymised export.** No redacted term appears in any byte of a fixture; replaying a fixture reproduces the boundary-restricted state at every step. `[D2.7]` A `basedOn` reference into another log survives export as its pinned version hash and position; the source log's identity is kept in clear when it is a published package namespace (a vendor's, by that vendor's declaration) and pseudonymised otherwise, so a fixture can say "rests on Context& package X at version h" without saying whose repository it came from.
- **G11. The ratchet.** `[D2]` A landing never grows a baseline; only an acceptance does. For every decision and every pair of positions p < q with no acceptance of that decision between them, baseline(q) ⊆ baseline(p).

A Context& architecture package is a set of accepted decisions under this vocabulary, together with any accepted `pf:` graph it realises; what a customer buys is G1 to G11 holding over their own code and specification against those decisions.

## 6. The contracts between parts

Five interfaces, each small, each expressed over the vocabulary. The product is the vocabulary plus these; everything else is replaceable.

| Contract | In | Out | First implementation |
|---|---|---|---|
| **Projector** | a repository at a commit, or `[D2]` a reporter input with its hash | quads with provenance from the G8 set | C# from project files; C# from Roslyn; `[D2]` the Product Framework behavioural-conformance runner as the first reporter |
| **Binding** | a What element and a target `[D2]` `[D2.8]` | the shape that satisfies or violates it in that target: a code shape for a language, a subgraph shape for a guest vocabulary | C#: `[DesignDecision]`, `[Contract]`, layer properties; `[D2]` `pf:`: Decider → pure core, Command → canonical REST route |
| **Proposer** | text (ADR draft, PR description, diff) `[D2]` and optionally a `pf:` subgraph at a position | a structured proposal in the vocabulary, via one tool call | a tool-calling model; a scripted double for tests |
| **Signer** | a decision version, a key, `[D2]` a grant | an acceptance, review, waiver or grant | SSH signatures |
| **Store** | commits over the named graphs of chapter 4 | positions, as-of reads, diffs, per-graph conditional commits; `[D2]` a positioned graph under a guest vocabulary with Writ's acceptance over it; `[D2.3]` a clock stamped by the writer on every header, the only clock the engine may read | an embedded event-sourced RDF store |

`[D2.1]` **Contracts are modules, and a process is the set it binds.** Two contracts are mandatory in every process: the Store (local or remote) and the Signer (because every write names an identity, even a refusal). The other three are optional, and their absence is a defined state, not an error:

| Contract absent | Consequence |
|---|---|
| Projector | no code-fact graph is written by this process; `land` accepts graph deltas only; `check` ranges over guest graphs and reports |
| Binding | What elements bind to no code shape; constraints over projector facts and contracts over reporter facts still evaluate |
| Proposer | `propose` accepts structured proposals only, not text |

A process that binds only the mandatory two is the decision engine: decisions, scopes, grants, waivers and acceptance over any positioned graph, with nothing about code in it. That is a complete, useful product on its own, and it is the same binary.

**Configuration is a decision or it does not exist.** A process takes exactly two inputs from outside the log: the address of the log (a path or a URL) and an identity from the environment (an SSH key, or OIDC and workload identity). Everything else that would conventionally be configuration (which projector edition a repository expects, which reporters a decision needs before it can be clean, who may sign what, which graphs an open question blocks) is a decision in the log, proposed, accepted and positioned like any other. There is no configuration file. A setting nobody signed is not a setting.

The C# analyzers run in two modes behind the same packages: rules in Roslyn (today's enumerated decisions, no graph required) or rules in the graph with Roslyn reduced to projector and binding. A team can start in the first and move to the second without changing its decisions.

`[D2]` The capability axis. A proposal records which proposer produced it and a landing records which builder produced the change (an agent identity, attributed to a human; the model behind it is not recorded in the log, by the no-model-ids rule). Refusals per decision per builder are therefore a query over the log, and that query is how a team learns which decisions are realised precisely enough for a smaller builder. Writ records it and draws no conclusion from it.

## 7. Implementation (today)

This chapter may change without chapters 1 to 6 changing.

| Part | Built from | Why this and not another |
|---|---|---|
| Store | Varve, embedded, file backend kept in Git | positions, as-of reads, `DiffAsync`, per-graph conditional commits and a header chain are the promise; no other store has them as a model rather than a feature |
| Acceptance | ledger-core (from product-cli), merged into this repository | the protocol is Writ's signature format; one repository for one promise |
| C# projector and binding | DecisionDriven.Analyzers, kept public and thin, both modes | Roslyn packaging has its own cadence |
| `[D2]` `pf:` guest graph | product-core's Turtle export, landed as a graph delta; its `--strict` checks ported as enumerated decisions | product-cli keeps authoring the What; Writ keeps signing it |
| Proposer | `[D2.9]` the scripted double (structured proposals; a transcript for `propose <text>`); the model-backed Proposer lives in Bailiff and drives Writ through MCP | no model SDK in Writ's binary; the proposer is the least important part and must stay swappable |
| Shapes and rules | SHACL and SPARQL `CONSTRUCT`, evaluated by Varve | standard languages, no proprietary rule language |
| Hosts | one binary: CLI, `serve`, MCP over stdio or HTTP, the CI gate, the as-of view | see 7.1 |

### 7.1 Hosts `[D2.1]`

One binary, Native AOT, built once; the five profiles of chapter 3 are verbs on it, not builds. The repository is laid out so that each contract is an assembly with no reference to any other contract's implementation, and the host assembly is the only place they meet:

| Assembly | Holds | References |
|---|---|---|
| `Writ.Vocabulary` | the `writ:` TBox, the protocol types, the named graphs, canonical hashing | nothing |
| `Writ.Store.Abstractions` / `Writ.Store.Varve` | the Store contract; its Varve implementation (embedded file backend; the server's single writer) | Vocabulary; Varve |
| `Writ.Store.Remote` | the Store contract as a client of a `serve` | Vocabulary |
| `Writ.Signer.Ssh` | the Signer contract over SSH signatures | Vocabulary |
| `Writ.Projector.CSharp.Files` / `.Roslyn` | the Projector contract for C# | Vocabulary |
| `Writ.Binding.CSharp` | the Binding contract for C# | Vocabulary |
| `Writ.Reporter.ProductFramework` | the behavioural-conformance runner as a reporter | Vocabulary |
| `Writ.Proposer` | the Proposer contract and its scripted double; `[D2.9]` no model client | Vocabulary |
| `Writ.Engine` | `propose`, `review`, `accept`, `check`, `diff`, `land`, `apply`, `explain`, `export`, `import` over the contracts | Vocabulary, Store.Abstractions |
| `Writ` (host) | the five profiles, the CLI, MCP over stdio and HTTP, the HTTP gate, the as-of view | everything above |

An analyzer fails the build if any contract assembly references another, or if `Writ.Engine` references an implementation. This is the layering discipline from Varve applied to Writ's own seams, and it is what makes "the decision engine alone" a property of the build rather than a promise.

**How each profile uses the store.** `writ` opens the Varve file backend in the repository directly (`derived/` ignored and rebuilt) and is the writer. `writ serve` opens one dataset and is its only writer; it serves the inbox (proposals from any repository, acceptance from anywhere, asynchronously), the remote gate (a `gate` posts a change and its position, gets the verdict and the position evaluated at), MCP over HTTP, the view, and the signing seam where a heavier scheme than SSH plugs in. `gate`, `mcp` and `view` use `Writ.Store.Remote` and commit through the server, never beside it.

Rules carried from Varve: OIDC and workload identity only, no API keys; a client that needs a revocation in force sends `Writ-Min-Position` and gets `503` with the server's position until it has caught up; every response states the position it was evaluated at.

**Fleet.** Several `serve` processes over one object store take a single writer and tier-1 followers from Varve's management plane. Writ adds nothing for this; it is a later milestone that costs the store contract no change.

Order of work: the vocabulary and the protocol page with their conformance suites (including the named graphs, grant scope, baseline and waiver); the property suite for G1 to G11 against an in-memory store; the C# file projector and the layer rule as the first end-to-end slice; `land` with the trailers and the status check; `[D2]` the `pf:` guest graph with product-cli's structural checks as the second slice; the MCP server; the proposer; `apply`; the as-of view; `export`/`import`.

## 8. Boundaries and decisions taken

- **Name.** Writ. Warrant was the first choice and was dropped on 2026-10-18: `warrant-dev` is an active Apache-2.0 authorization service with a `warrant` CLI and `warrant.dev`. "Warrant" survives inside Writ as the term for what an acceptance confers on a decision at a position.
- **Licence.** Apache-2.0. The engine is open; Context& architecture packages, including any accepted `pf:` graphs they carry, are content on it.
- **Repositories.** One new repository for Writ: vocabulary, protocol, suite, CLI, server, MCP, gate, view, and the merged ledger. The analyzers stay in their public repository. Varve stays in its own; Writ is an embedded consumer and puts nothing Writ-specific into it. `[D2]` product-cli stays in its own: it authors the `pf:` graph and owns the `pf:` vocabulary; Writ consumes its export and never extends `pf:`. `[D2.4]` (2026-10-21) product-cli's scope is the What alone (Product Framework §3 and the behavioural-conformance wire protocol of §6.3.1), rewritten in .NET on Varve with its own draft log; the How (§4), work units and seams (§5), delivery and direction (§7), and every decision and signature live in Writ. The `pf:` ontology keeps its §4 to §7 classes as IRIs Writ's decisions reference; no tool authors them as How.
- **Language.** The whole repository is .NET and C#. The ledger is rewritten, not ported: the protocol page and its conformance fixtures carry over, the code does not. `writ import` reads today's ledger stores so existing `.decisions/` directories migrate, and the existing tool is retired once the C# implementation passes the same suite. The `dec` orchestrator is a separate tool and stays out.
- `[D2]` **One decision vocabulary (2026-10-20).** `pf:` §4.1 (`TopDecision`, `Principle`, `Pattern`), `.ddd` decisions and the `.decisions` ledger collapse into `writ:`: a `pf:Principle` is an enumerated decision, a `pf:Verification` its violation shape, a `pf:Pattern` a binding, `pf:applies` a citation, `pf:enforces` the rule-to-shape edge. `.ddd` and `.spec` are not imported as stores; what they held that Writ needs (G3 three times over, the one hashing law) is in the protocol once.
- `[D2]` **The What is ground and execution space at once (2026-10-20).** For an act on the specification, the `pf:` graph is the ground; for an act on code realising it, the same graph at the same position is part of the execution space. One graph, one position, two readings; the Store contract does not distinguish them.
- `[D2]` **Two time axes, one log (2026-10-20).** The What-version and How-version of Product Framework §7.3 are named positions in one log, not two logs. `diff p q` over the `pf:` graph classifies the bump from the node kinds that changed.
- **Not in scope.** A latent planner, reinforcement learning, or any learned model inside the gate. Writ's "learning" is a proposer feeding a human-accepted log, and it is auditable precisely because nothing learned sits between a decision and a verdict. `[D2]` A reporter is not a learned model: its output is evidence with provenance, not a verdict.
- **Open, decided by evidence.** Whether blends with emergent constraints are needed (the Varve spike); whether the action grammar (chapter 6, binding) can generate code from accepted decisions rather than only check it. `[D2]` Whether refusals-per-builder is a usable capability signal; Writ's own log is the first dataset. All additive to this definition.

## Appendix: name availability (checked 2026-10-18)

- NuGet: no `Writ` or `Writ.*` package.
- GitHub: `writ` is an inactive personal account with no repositories; an organisation needs another handle (`writ-dev`, or the product under an existing owner).
- npm: `writ` exists as a small literate-programming tool; Writ ships no npm package, so there is no conflict in use, only in search.
- `writ.dev` resolves to something and refuses automated fetching; check by hand before relying on it.
- EU trademark: not checked.
