# 0008 — Commit traceability and the session pattern

## Status

Accepted. 2026-10-18.

## Context

Substantially all of Writ's code and every ADR will be produced in
AI-assisted sessions under the maintainer's direction, as Varve's were. Varve
settled, over ADRs 0033 (commit traceability), 0034 (commit signing and the
sandbox exception), 0087 (DCO and the responsible human) and 0088 (only
checked commits reach `main`), a pattern that a product whose promise is
"every decision accepted by a named human, every verdict reproducible" cannot
hold itself to less than.

## Decision

Writ adopts Varve's pattern. Written out so this repository stands alone:

- **Every commit** is a conventional commit, one logical change, and carries
  `Refs #N` or `Closes #N` in its body (a closing keyword only as a trailer
  line of its own), a `Signed-off-by:` naming the human who may contribute
  the code (for a session's commit, its responsible human in
  `eng/identities.json` or a delegate), and a signature where the committer is
  a human. A session commits as its agent identity (`Claude (Emil)
  <claude+emil@okkels-klein.dk>`), SSH-signed when the sandbox can sign.
- **A commit message never carries a model's identifier.** A tool's co-author
  trailer naming the product is not one. Prose elsewhere says "developed with
  AI assistance under human review" and names no product.
- **Every AI-assisted session files a record** in `docs/traceability/`, named
  `YYYY-MM-DD-issue-N-<slug>.md`, with the prompt, the tool and the model
  named exactly as the session's metadata reports them, the report, and the
  commits. Where the tool will not write the model, the record says so and
  the maintainer fills it in.
- **A session plans first and waits for approval**, reads the definition and
  the ADRs before proposing anything structural, lands through one pull
  request from its branch, never suppresses a rule, and when two sessions run
  in parallel the one that lands second merges `main` and reconciles.
- **`main` accepts only checked commits.** A pull request lands at its
  approved head, fast-forwarded, never by a merge commit. The GitHub ruleset
  and the gates that enforce this are not in this commit; until they are,
  this ADR is the rule and the maintainer is the gate.
- **A session never writes `accepted-by`** on a decision it filed (ADR 0010).

Writ's own `land` command is the intended successor to this pattern for this
repository: when Writ can gate itself, the pattern above is what `land`
enforces, and this ADR is superseded by the one that turns it on.

## Alternatives considered

- **Adopt Varve's ADRs by reference only.** Rejected: a reader of this
  repository would need four ADRs from another to know what a valid commit is.
- **Attribute every commit to the human.** Rejected: it hides who wrote what,
  and the traceability record then has nothing to tie a commit to.
- **Require signatures from sessions without exception.** Taken where the
  sandbox can sign; Varve ADR 0034 records why a cloud session may be exempt
  by ruleset bypass, and the same reasoning applies.

## Consequences

Every session costs a record and an issue. Until the gates exist in `eng/`
and the ruleset is applied, compliance is by review. The first gates to port
are `issue-refs`, `dco` and `identities`, in that order, and they are on the
roadmap before any `src/` project.
