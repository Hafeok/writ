---
set: vocabulary-iri-and-read-forever
namespace: writ
adr: 0007
decisions:
  - key: VocabularyIri
    statement: "The vocabulary namespace is https://decision-driven-design.dk/ns/writ# with prefix writ:, permanent, served as the specification page and as Turtle"
  - key: TermsAreNeverRenamed
    statement: "A term is never renamed; a deprecated term stays defined with owl:deprecated true; a second vocabulary is a second namespace"
  - key: FourFormatsSpecifiedBeforeImplementation
    statement: "The vocabulary, the protocol, the code-fact graph and the fixture format each have a specification page and a conformance suite before any implementation"
  - key: ReadForeverFromTheFirstRelease
    statement: "Every version of each format ever written by a release is read by every later release, tested by golden files that are never deleted"
---

The rulings of [ADR 0007](../adr/0007-vocabulary-iri-and-read-forever.md). Filed unaccepted by the session.
