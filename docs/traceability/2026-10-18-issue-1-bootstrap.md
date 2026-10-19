# Bootstrap: definition, ADR set zero, build policy

> **Recorded contemporaneously**, by the session that did the work, under
> [ADR 0008](../adr/0008-commit-traceability-and-the-session-pattern.md).
> The maintainer's messages are verbatim. The transcript is held by the
> maintainer.

| | |
|---|---|
| **Issue** | [#1](https://github.com/Hafeok/writ/issues/1), opened by this session |
| **Date** | 2026-10-18 |
| **Tool** | Claude, a cloud session started from the Claude app on a phone and linked to the maintainer's computer |
| **Model** | `claude-fable-5-1`, from the session's own metadata |
| **Session identifier** | `session_01WmRJQfk1yJG5JRVt5tcEgE` |
| **Branch** | `claude/bootstrap`, from an empty `main` |
| **Machine** | a cloud container; .NET SDK 10.0.402 installed in the session with `dotnet-install.sh` |

The history was re-signed in a second session, which wrote no product
content:

| | |
|---|---|
| **Date** | 2026-10-19 |
| **Tool** | Claude Code 2.1.303, a cloud session started from the Claude desktop app |
| **Model** | `claude-opus-5-5`, from the session's own metadata |
| **Session identifier** | `session_01TPvQAkrVW1mLey1hhWRwCA` |
| **Branch** | `claude/bootstrap`, rewritten in place |
| **Machine** | a cloud container (environment `env_011CV1nepK2xDgyxPJFr46Db`) carrying `CLAUDE_GIT_SIGNING_KEY`; .NET SDK 10.0.401 preinstalled |

## The prompts

The session ran in the Writ project, whose project prompt is the summary of
`docs/product-definition.md` (the definition itself was attached). The
maintainer's messages, in order:

> I have created the repo writ under my own hafeok account. Let's get started

The session proposed a bootstrap pull request with no engine code and asked
three questions: the vocabulary IRI, the .NET version and whether Varve is on
NuGet, and the agent identity for commits.

> Let's do decision-driven-design.dk I own that. Varve is on nuget and its .NET 10 LTS. And its the same as the Varve pattern.

The session could not find Varve on NuGet by search and asked for the package
id and the identity's key.

> https://www.nuget.org/packages/Varve.Protocol.Client/0.1.0-preview.7 - the key etc is in the claude session

## What the session did

1. Read Varve (`Hafeok/Varve`, read-only clone): `AGENTS.md`, `docs/brief.md`
   (constraints 1 to 6), `Directory.Build.props`, `Directory.Build.targets`,
   `Directory.Packages.props`, `.editorconfig`, ADR 0001, the decision-set
   form in `docs/decisions/README.md`, `docs/traceability/README.md`, a recent
   record, `eng/identities.json`, and the last commits for the agent identity
   and the commit-message form.
2. Found the session's git identity already configured for SSH signing, and
   set the repository's `user.name` and `user.email` to the agent identity
   Varve's commits use.
3. Opened issue #1.
4. Wrote the definition (Draft 1, verbatim), ADRs 0001–0010 with a decision
   set each (filed unaccepted), `Directory.Build.props`, `Directory.Build.targets`,
   `Directory.Packages.props` (versions resolved from nuget.org on
   2026-10-18: `DecisionDriven.Analyzers` 0.1.0-preview.8, the two
   `Microsoft.CodeAnalysis.*Analyzers` 5.6.0, MinVer 8.0.0), `global.json`
   (10.0.401, `latestFeature`), `.editorconfig` adapted from Varve's,
   `AGENTS.md`, `CLAUDE.md`, `README.md`, `NOTICE`, `LICENSE` (the canonical
   Apache-2.0 text), `docs/spec/README.md`, `docs/roadmap.md`, this record.
5. Verified the build files with a throwaway project (not committed): the
   generator read `docs/decisions/`, `DecisionDriven.Ledger.Writ.NameWrit.TheNameIsWrit`
   resolved, and citing it was `CS0618`, the state ADR 0010 expects.

## Findings reported to the maintainer

- **Varve has no SHACL.** Varve's `AGENTS.md` lists it as not built; the
  definition's chapter 7 names SHACL as a rule language evaluated by Varve.
  Recorded as an open question in ADR 0006 and the roadmap, not decided.
- **Licence divergence.** Varve is MPL-2.0 (its ADR 0031); the definition
  says Apache-2.0. ADR 0003 follows the definition and states the divergence.
- **`Varve.Protocol.Client` is at 0.1.0-preview.8** on nuget.org, one past the
  version the maintainer linked. No Varve package is registered in this
  commit; Varve enters the register with the store contract's first
  implementation.
- **The browser is not a Writ host.** Varve's constraint 3 is restated in
  ADR 0005 rather than inherited verbatim.

## Signing

The commits were first made as `Claude (Emil) <claude+emil@okkels-klein.dk>`,
Varve's agent identity, and GitHub reported them `unknown_key`: this
session's environment carries no `CLAUDE_GIT_SIGNING_KEY`, only the
platform's signer, which is bound to `noreply@anthropic.com`. The commits
were rewritten as `Claude <noreply@anthropic.com>`, the agent's second
address in `eng/identities.json`, so they verify; the sign-off and the
session trailer are unchanged. Varve's `.claude/hooks/cloud-git-identity.sh`
and `.claude/cloud-setup.sh` were brought in so that, once the maintainer
sets `CLAUDE_GIT_SIGNING_KEY` on the Writ environment at claude.ai/code and
installs the setup script, later sessions sign as `Claude (Emil)`.

The second session ran with the key set, and the hook signed as `Claude
(Emil) <claude+emil@okkels-klein.dk>` (`SHA256:xDu5EyJd05ROum1g+8Aj1Up3MjE6RbHnI70/xNHljDY`).
It rewrote the history so that every commit is the agent identity's and
verifies. The root commit `cfd87d9a45642043059c87a05f1b469ae808c377`, which
GitHub reported `unknown_key`, was replaced by
`480256a98d36b5d6b144ecb7625516a1e02139df`: the same empty tree and the same
message, signed with the agent key. The seven content commits were rebased
onto it with the author reset to the agent identity, re-signed, and pushed
over `claude/bootstrap` with a lease on its old head `b6848e9`. Their trees
are unchanged, and their messages are unchanged byte for byte, trailers
included: the sign-off, `Refs #1`, and the co-author and `Claude-Session:`
trailers of the session that wrote the content. `main` was force-pushed with a
lease on `cfd87d9`. This is the one time `main`'s history may be rewritten: it
held no content, only the empty root. GitHub reports all eight commits
`verified: true`, `reason: valid`.

## Commits

Listed on the pull request. Each carries `Refs #1`, `Signed-off-by: Emil
Okkels Klein`, the agent identity, and an SSH signature.
