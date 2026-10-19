---
set: commit-traceability-and-the-session-pattern
namespace: writ
adr: 0008
decisions:
  - key: EveryCommitRefsAnIssueAndIsSignedOff
    statement: "Every commit is a conventional commit with Refs #N or a Closes #N trailer and a Signed-off-by naming the responsible human in eng/identities.json"
  - key: SessionsCommitAsTheAgentIdentity
    statement: "A session commits as its agent identity, SSH-signed when the sandbox can sign, and a commit message never carries a model's identifier"
  - key: EverySessionFilesATraceabilityRecord
    statement: "Every AI-assisted session files a record in docs/traceability/ naming the tool and the model exactly, with the prompt, the report and the commits"
  - key: PlanFirstOnePullRequestReconcileSecond
    statement: "A session plans first and waits for approval, lands through one pull request, never suppresses a rule, and the second of two parallel sessions merges main and reconciles"
  - key: OnlyCheckedCommitsReachMain
    statement: "main accepts only checked commits, fast-forwarded at an approved head, never by a merge commit; until the gates exist the maintainer is the gate"
---

The rulings of [ADR 0008](../adr/0008-commit-traceability-and-the-session-pattern.md). Filed unaccepted by the session.
