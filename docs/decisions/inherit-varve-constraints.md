---
set: inherit-varve-constraints
namespace: writ
adr: 0005
decisions:
  - key: ManagedCodeOnly
    statement: "100% managed code: no P/Invoke and no native asset in any shipped artifact"
  - key: AotAndTrimmingCompatible
    statement: "Native AOT and trimming compatible: no reflection in hot paths, no Reflection.Emit, source generators where code generation is needed, IL-prefixed diagnostics at error severity and never in NoWarn"
  - key: OneBinaryThreeWays
    statement: "One binary runs embedded, standalone and in a fleet over one store contract that is an abstraction from the first slice; the browser is not a host"
  - key: MinimalDependenciesByAdr
    statement: "Prefer the BCL; every third-party package needs an ADR and an entry in the register"
  - key: CurrentLtsDotNetAndAllocationIsADefect
    statement: "Current LTS .NET and current C#; allocation per quad, per verdict and per term in the projector and the check is a defect"
  - key: NoCopiedCode
    statement: "No code is copied from the ledger, from Varve or from the analyzers; they are read for behaviour and referenced as packages"
  - key: StableDependenciesStrictlyDownward
    statement: "Fixed layers, references strictly downward, same-layer references are violations, and contracts live in the lowest layer that can define them"
  - key: LowCouplingNoStaticState
    statement: "No shared mutable state, no static registries, and a public API baseline on every packable project"
  - key: HighCohesionNoGrabBag
    statement: "One package, one reason to change; no Common, Core, Utils, Helpers or Abstractions package"
  - key: EveryRuleIsAnAnalyzer
    statement: "Every architecture rule is an analyzer that fails the build; a rule only in a document is not a rule"
  - key: LayerTableByTheFirstProjectAdr
    statement: "Writ's layer table is decided by the ADR that creates the first src/ project, and every project declares ArchLayer from that commit"
---

The rulings of [ADR 0005](../adr/0005-inherit-varve-constraints.md). Filed unaccepted by the session.
