# Cloud setup: claude-code-bootstrap replaces the copy from Varve

> **Recorded contemporaneously**, by the session that did the work, under
> [ADR 0008](../adr/0008-commit-traceability-and-the-session-pattern.md).
> The maintainer's message is verbatim. The transcript is held by the
> maintainer.

| | |
|---|---|
| **Issue** | [#16](https://github.com/Hafeok/writ/issues/16), opened by this session |
| **Date** | 2026-10-26 |
| **Tool** | Claude Code 2.1.310, a cloud session started from the Claude desktop app |
| **Model** | `claude-opus-5-5`, from the session's own metadata |
| **Session identifier** | `session_01C6nbpm7YumzvFxLTqg5Hjc` |
| **Branch** | `claude/wonderful-thompson-ff41va`, from `main` at `3b1c5af` |
| **Machine** | a cloud container (environment `env_011CV1nepK2xDgyxPJFr46Db`) provisioned by claude-code-bootstrap `v3`, carrying `CLAUDE_GIT_SIGNING_KEY`; .NET SDKs 10.0.403 (the bootstrap's) and 10.0.401 (installed by the old `.claude/cloud-setup.sh`) |

## The prompt

> Writ's cloud setup has moved to the shared bootstrap (github.com/Hafeok/claude-code-bootstrap, v3), which every cloud environment now runs. Writ carries a copy of Varve's setup that now duplicates it. Before removing anything, verify in this session:
>
> - The session start showed lines beginning with "git-identity:" (from the bootstrap) and "cloud-git-identity:" (from this repo). Quote both.
> - `git -C /opt/claude-code-bootstrap describe --tags` reports v3 or later.
> - If the repo has a global.json, `dotnet --version` from the repo root resolves to an SDK the bootstrap cached, i.e. there's no /var/tmp/claude-code-bootstrap/dotnet-*.log. If it resolved only because .claude/cloud-setup.sh installed a pinned SDK, say which SDK and stop at step 1.
>
> If any check fails, report it and change nothing. Otherwise:
>
> 1. Look at .claude/cloud-setup.sh. Delete it if all it does is install openssh-client and a .NET SDK, and write /etc/profile.d/dotnet.sh. The bootstrap covers all of those, and installs any SDK pinned in global.json that its cached SDKs don't satisfy. If it does anything else that Writ needs, keep the file with only those parts. It still runs at session start through the bootstrap's hook, once per VM.
> 2. Delete .claude/hooks/cloud-git-identity.sh and remove its SessionStart entry from .claude/settings.json; delete the file if that leaves it empty. The bootstrap's user-level hook signs with the same key and identity, and also writes allowed_signers.
> 3. Look for references to cloud-setup.sh, cloud-git-identity.sh, Varve's curl one-liner or "#79" (a Varve issue) in docs, AGENTS.md and CLAUDE.md. Update anything that describes current behaviour to say the environment is provisioned by claude-code-bootstrap. Leave historical records unchanged.
> 4. Don't touch .devcontainer/ or any local setup.
>
> Then rebuild to confirm nothing depended on the removed files: run `dotnet build` on the main solution, or whatever the repo's build is.
>
> Follow the repo's own conventions for issues, records and commits if it has them, and open a PR.

## What the session found

- **Session start** printed both lines, with the same identity and key:
  `cloud-git-identity: commits are signed as Claude (Emil) <claude+emil@okkels-klein.dk> with SHA256:xDu5EyJd05ROum1g+8Aj1Up3MjE6RbHnI70/xNHljDY.`
  and
  `git-identity: commits are signed as Claude (Emil) <claude+emil@okkels-klein.dk> with SHA256:xDu5EyJd05ROum1g+8Aj1Up3MjE6RbHnI70/xNHljDY.`
- **The bootstrap** is at `v3`.
- **The SDK.** `global.json` pins 10.0.401 with `rollForward: latestFeature`.
  `dotnet --version` from the root reports 10.0.403, which the bootstrap
  cached (its directory predates the setup script's 10.0.401 by a minute),
  and there is no `dotnet-*.log` in `/var/tmp/claude-code-bootstrap/`. The
  10.0.401 the setup script installed is present but is not the one that
  resolves.
- **`.claude/cloud-setup.sh`** did only three things: install
  openssh-client, install SDK 10.0.401, and write `/etc/profile.d/dotnet.sh`.
- **`.claude/settings.json`** held only the identity hook's SessionStart
  entry.
- **References.** ADR 0008's Decision names the hook as what writes the
  agent identity; that describes current behaviour, and the ADR is accepted,
  so it gets a dated add-only amendment (ADR 0001) rather than an edit. The
  bootstrap record (`2026-10-18-issue-1-bootstrap.md`) mentions both files
  as history and is unchanged. Nothing mentions Varve's curl one-liner
  outside the deleted script, or "#79". AGENTS.md and CLAUDE.md mention
  neither file. There is no `.devcontainer/`.

## What the session did

1. Opened #16.
2. Deleted `.claude/cloud-setup.sh`, `.claude/hooks/cloud-git-identity.sh`
   and `.claude/settings.json`, which was left empty.
3. Appended an amendment to ADR 0008 saying the environment is provisioned by
   claude-code-bootstrap and the identity is written by its session-start
   hook. The decision set is unchanged: its rulings do not name the hook.
4. Rebuilt. There is no solution yet (AGENTS.md: "once a solution exists"),
   so `dotnet build` at the root has nothing to build. To exercise the
   repository-wide build policy and `global.json` without the removed files,
   a throwaway class library was built in a copy of the tree with `.claude/`
   removed: it resolved SDK 10.0.403 and built clean in Release, 0 warnings, 0
   errors, once its public type had the XML comment the policy requires. The
   copy was then deleted.

## Commits

Listed on the pull request. Each carries `Refs #16`, `Signed-off-by: Emil
Okkels Klein`, the agent identity, and an SSH signature.
