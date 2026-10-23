# Traceability

One record per AI-assisted session, as [ADR 0008](../adr/0008-commit-traceability-and-the-session-pattern.md)
requires: the prompt, the tool and the model named exactly as the session's
metadata reports them, the report, the issue and the commits. Where the tool
will not write the model's identifier, the record says so and the maintainer
fills it in; a blank model is an incomplete record.

Records name the tool and the model. Prose elsewhere says "developed with AI
assistance under human review" and names no product. The transcript itself is
held by the maintainer.

Named `YYYY-MM-DD-issue-N-<slug>.md`.
