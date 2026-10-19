---
set: licence-apache-2-0
namespace: writ
adr: 0003
decisions:
  - key: ProjectLicence
    statement: "Writ is licensed under Apache-2.0, with the canonical text verbatim in LICENSE and the copyright line in NOTICE"
  - key: HeaderOnEveryFile
    statement: "Every .cs file carries the short Apache-2.0 header from .editorconfig's template"
  - key: PackageLicenceExpression
    statement: "PackageLicenseExpression is the SPDX expression Apache-2.0, never a licenseUrl, and LICENSE and NOTICE are packed into every package"
  - key: StatedDivergenceFromVarve
    statement: "Writ's Apache-2.0 is a stated divergence from Varve's MPL-2.0; the two compose because Writ links Varve and never modifies its files"
---

The rulings of [ADR 0003](../adr/0003-licence-apache-2-0.md). Filed unaccepted by the session.
