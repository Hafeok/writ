# Definition Draft 2: the repository follows the definition

> **Recorded contemporaneously**, by the session that did the work, under
> [ADR 0008](../adr/0008-commit-traceability-and-the-session-pattern.md).
> The maintainer's messages are verbatim except where the attached files are
> named rather than inlined. The transcript is held by the maintainer.

| | |
|---|---|
| **Issue** | [#18](https://github.com/Hafeok/writ/issues/18), opened by this session; also [#19](https://github.com/Hafeok/writ/issues/19) and [#20](https://github.com/Hafeok/writ/issues/20) |
| **Date** | 2026-10-28 |
| **Tool** | Claude Code 2.1.312, a cloud session started from the Claude desktop app |
| **Model** | `claude-opus-5-5`, from the session's own metadata (configured and last served) |
| **Session identifier** | `session_01NbWSYQeoMXLa1GM3fht9zo` |
| **Branch** | `claude/happy-ritchie-h68vm3`, fast-forwarded from `3b1c5af` to `main` at `6c090ad` before the first commit |
| **Machine** | a cloud container (environment `env_011CV1nepK2xDgyxPJFr46Db`) provisioned by claude-code-bootstrap `v3`, carrying `CLAUDE_GIT_SIGNING_KEY`; .NET SDK 10.0.403 |

## The prompts

The first message attached a definition file, Draft 2 through `[D2.8]`:

> Replace Draft 1 of the product definition with Draft 2 (through D2.8)
> Hafeok/writ carries `writ-product-definition.md` at Draft 1 (2026-10-18). The attached file is Draft 2, dated 2026-10-20 with amendments through `[D2.8]` of 2026-10-28, and it is the authority: every design decision since the 18th was made against it, not against what the repository holds. This session brings the repository up to date and nothing else.
> Read first. The attached definition in full; the changelog at its head lists every amendment with its tag. Then the repository: `README.md`, `CLAUDE.md`, every ADR under the decisions directory, the ledger’s current records, and anything that cites a chapter, a guarantee number, a contract name or the word “realisation”. Produce the plan below and wait for approval before changing a file.
> Plan, then do, in one PR:
>
> 1. Replace the definition file with the attached content, byte for byte. Do not edit it; it is ruled material, and anything you think is wrong in it goes in the PR description as a question, not a change.
> 2. Find every place the repository depends on Draft 1 and reconcile it to Draft 2, by supersession where the place is a decision and by edit where it is prose. The known differences, so you know what to look for:
>    * Contracts: the Realisation contract is now the Binding contract, narrowed to a What element mapped to a shape in a target; constraints evaluate over projector facts and contracts over reporter facts. Any assembly, namespace, analyzer id or ADR naming “Realisation” is renamed; `writ:realisation` is never minted.
>    * Guarantees: eleven, not ten. G2 is acceptance under grant; G3 covers review, grant and waiver; G6 covers open questions and session closes at recorded clocks; G7 crosses logs; G8’s provenance set is `file, compiler, graph, runner, data, telemetry, attestation, deployment-declared, deployment-observed`; G11 is the ratchet.
>    * Surface: five profiles (`writ`, `writ serve`, `writ gate`, `writ mcp`, `writ view`); `check` has three outcomes (clean, violation, open question); `accept` takes `--baseline`; `land` takes graph deltas as well as patches; the MCP section and sessions are new.
>    * Formats: the named graphs by writer; guest vocabularies with `pf:` first; grants with scope; baselines; waivers; reports; the header clock as the only clock; two protocol conformance classes; cross-log `basedOn` by pinned version.
>    * Chapter 7: assemblies per contract with an analyzer forbidding cross-references; the model-backed Proposer lives outside Writ (Bailiff), the shipped binary binds the scripted double.
>    * Chapter 8: product-cli’s scope is the What alone; one decision vocabulary; the What is ground and execution space at once; two time axes in one log.
> 3. File the change as a decision in Writ’s own ledger: the definition’s version is a decision like any other, with the prior version superseded and the reason stated (outside-in: the definition changed first; the repository follows). You file it; Emil accepts it. Do not create an acceptance.
> 4. Where an existing accepted decision contradicts Draft 2, file a superseding version that says so and cites the Draft 2 tag; never diverge silently and never edit the accepted record.
> 5. If anything in the repository cannot be reconciled without a product-level choice (for instance a package name already published under “Realisation”), stop, list it in the PR description, and leave that item undone.
>
> Discipline, as for every Writ session: signed commits as the agent identity, no model identifiers anywhere in a commit or a record, a `Claude-Session:` trailer, a traceability record for the PR, no suppression of analyzers or rules, a release descriptor if the change is releasable (it is not: this is documentation and ledger only). One PR, opened for Emil to ratify by merging. If a parallel session lands first, you reconcile.
> Report back with: the plan as approved, the list of places reconciled, the ledger decisions filed with their ids, and anything left for Emil to decide.

The session read the repository and proposed a plan with seven questions and
two conflicts. The second message attached a revised definition, Draft 2
through `[D2.9]`, and answered:

> Approved, with these answers. The attached definition replaces the earlier attachment; use this one in step 1.
>
> Questions 2, 3, 4: fixed in the definition. [D2.9] now says what the brief said about the Proposer and Bailiff; roadmap #10 follows it. The changelog is in order and has the D2.4 entry. “Realisation” no longer appears as a term; “realises” as a verb (realises_version, “code realising the What”) is intended and stays.
>
> Question 1, Writ.Store.Abstractions: leave for the ADR that creates the first src/ project, as you proposed. ADR 0005’s ban stands until then.
>
> Question 5: correct, keys are never renamed; FourFormats… keeps its key with a superseded statement.
>
> Question 6: do not supersede OneBinaryThreeWays. Embedded is writ, standalone is serve, fleet is several serves; the other three profiles are clients of a serve, not ways of running the store. Prose only.
>
> Question 7: out of scope; open a separate issue for the .editorconfig path.
>
> Conflict 1, the co-author trailer: drop it. A model name is a model identifier; the precedent on main is the thing being corrected, not a rule.
>
> Conflict 2, the traceability record: it names the model. The rule covers commits and ledger records (ADRs, decision sets, anything that will ever be a writ: record). The traceability record is outside the log and is the one place a model identifier belongs, exactly as Bailiff’s run manifest is. ADR 0008 stands.
>
> One more: ADR 0012 adding the product-cli ruling from D2.4 and ADR 0013 adding “writ:realisation is never minted” are both right; file them as you planned. Proceed.

## What the session found

- The definition lives at `docs/product-definition.md`, not
  `writ-product-definition.md`; the path was kept because everything links it.
- Writ's own ledger is still the interim form of ADR 0010: ADRs in
  `docs/adr/` and decision sets in `docs/decisions/`. No set carries an
  acceptance. No `writ:` term, assembly, namespace, package or analyzer id
  exists yet, so nothing was named "Realisation" outside prose.
- Accepted rulings Draft 2 contradicts: ADR 0004's
  `AnalyzersStayPublicWithTwoModes` ("realisation") and ADR 0007's
  `FourFormatsSpecifiedBeforeImplementation` (four formats; "file or
  compiler" provenance).
- "G1 to G10" in the reasoning, not the rulings, of ADRs 0003, 0006 and 0010.
- `main` had moved by PR #17 (the cloud setup removed, an add-only amendment
  to ADR 0008); no other session's pull request was open.
- In the definition as committed, §4 "Mappings and bindings" still reads
  "where the realisation is the subgraph shape" once. Raised as a question on
  the pull request; the file is not edited.

## What the session did

1. Opened #18; later #19 (the `.editorconfig` path, out of scope) and #20
   (the `pf:` second slice, a milestone Draft 2's order of work adds).
2. Fast-forwarded the branch to `main`.
3. Replaced `docs/product-definition.md` with the second attachment, checked
   byte-identical with `cmp` (sha256 `9dd680ef…2ac9d`).
4. Filed ADR 0011 (the definition's version), ADR 0012 (superseding ADR
   0004's `AnalyzersStayPublicWithTwoModes`; product-cli's What; Bailiff's
   Proposer) and ADR 0013 (superseding ADR 0007's
   `FourFormatsSpecifiedBeforeImplementation`; `writ:realisation` never
   minted), each with its decision set, all unaccepted. ADRs 0004 and 0007
   changed only their Status lines; the two keys moved to the new sets under
   the same names.
5. Reconciled `AGENTS.md`, `README.md`, `docs/spec/README.md` and
   `docs/roadmap.md`, and renamed #14 to "Roslyn projector and binding".
6. Verified the sets with a throwaway project in a copy of the tree (not
   committed, then deleted): the generator read every set, the six rulings
   cited resolved, and each citation was `CS0618`, the state ADR 0010
   expects. The probe's own static array tripped `DD0004`, which concerns
   the probe and nothing committed.

## Commits

Each carries `Refs #18`, `Signed-off-by: Emil Okkels Klein`, the
`Claude-Session:` trailer and no co-author trailer, is committed as the
agent identity, and is SSH-signed.

- `9925cbc` docs: the product definition, Draft 2 through D2.9
- `eba80ae` docs(adr): 0011, the product definition is Draft 2 through D2.9
- `d721260` docs(adr): 0012, repository boundaries under Draft 2
- `8ec96c3` docs(adr): 0013, formats under Draft 2
- `2da21c3` docs: AGENTS.md and README.md under Draft 2
- `b0b7c92` docs(spec): the specification index under Draft 2
- `86ab4f0` docs(roadmap): the milestones under Draft 2
- this record

## Addendum, 2026-10-28

Adds to the record and changes nothing above. After the pull request was
opened, the maintainer answered its first question: the noun in §4 was not
intended, and was fixed in the definition. The maintainer's message:

> 1. Not intended; fixed. The attached definition replaces the previous one; one word changed in §4 (“where the shape is a subgraph shape”). Copy it over `docs/product-definition.md` byte for byte as one more commit on the same PR. Nothing else in the file changed.
> 2. Keep `ModelBackedProposerLivesInBailiff`. It follows from `[D2.9]` and belongs in ADR 0012.
> 3. Acceptance is mine. I’ll accept 0011 to 0013 after merging #21.

The session copied the corrected text over `docs/product-definition.md`,
checked it byte-identical with `cmp`, and confirmed that the diff from the
previous text is that one phrase in §4, "Mappings and bindings": "where the
realisation is the subgraph shape" now reads "where the shape is a subgraph
shape". The definition's sha256 is now
`2c6caed34b27c3b91c09334a9cc4ff9b21e947cd601ccc91a55b3aa3b06808df`,
replacing `9dd680ef…2ac9d` above. "Realisation" now appears in the file
only in the D2.8 and D2.9 changelog entries and in "`writ:realisation` is
never minted".

`ModelBackedProposerLivesInBailiff` stays in ADR 0012 as filed. ADRs 0011
to 0013 remain unaccepted; the maintainer accepts them after the merge.

Commits after this record's first version, each with the same trailers and
signature as above:

- `567184c` docs: the product definition, Draft 2 through D2.9, §4 corrected
- this addendum
