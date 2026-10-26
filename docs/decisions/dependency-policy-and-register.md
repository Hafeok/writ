---
set: dependency-policy-and-register
namespace: writ
adr: 0009
decisions:
  - key: PackagesPropsIsTheRegister
    statement: "Directory.Packages.props is the register: central package management with transitive pinning, and no version in a project file"
  - key: EveryPackageVersionCitesAnAdr
    statement: "Every PackageVersion carries Adr=NNNN naming the decision that admits it, and Scope= when confined to some projects"
  - key: VersionsResolvedNeverRemembered
    statement: "A version is resolved from nuget.org when a package is added, never taken from memory; latest stable by default"
  - key: PreviewsTrackedAtLatestPrerelease
    statement: "Varve and DecisionDriven.Analyzers are taken at their latest prerelease, and a bump carries their breaking changelog entries in its commit body"
  - key: RoslynFloorIsTheFirstNet10Sdk
    statement: "The Roslyn floor for analyzer authoring is the line shipped with the first .NET 10 SDK, raised only with a reason"
---

The rulings of [ADR 0009](../adr/0009-dependency-policy-and-register.md). Filed unaccepted by the session.
