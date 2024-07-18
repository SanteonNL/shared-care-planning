
# Motivation for Shared Care Planning
Rising healthcare costs are unsustainable in the long term. By making healthcare more efficient, we can ensure the sustainability of healthcare systems, safeguarding access to care for future generations. In The Netherlands, many patients visit multiple practitioners during their treatment, at different organizations. Continuous care coordination and/or collaboration comes with high costs. Currently, these practitioners either handover the patient to a different care-provider or practitioners use the same IT-system for collaboration. Both methods have severe disadvantages. 

Using the Dutch handover-process, it requires the initiating party to write a hand-over-letter, collect and send data. The 'receiving' party has to read this letter and decide what to do with the data; either reconciliate (copy) the data in their own system or discard the data. The receiving party is often required to send back a 'discharge' letter after treatment. The process of handovers involves a significant amount of administrative work. When two practitioners would like to collaborate (back and forth) using this handover-process, the administrative burden increases because data might be duplicated at every handover. When more than two parties are involved in a collaboration, the handover-process is even more challenging to coordinate care and relevant/up-to-date data.
When practitioners of different organizations use the same IT-system, collaboration is often a lot easier. These systems (e.g. a regio-wide implemented EHR or a care network/collaboration platform) usually provides members of the careteam functionality to share medical records, to communicate and to coordinate/plan care activities for a patient. The downside of these systems is that every participant of the careteam has to use that same system. In The Netherlands, many care organizations participate in multiple organization-associations. Implementing an IT-system in a group of care-organizations can be challenging and often results in a lock-in with that vendor. In some organizations, different systems have been implemented for multiple organization-affiliations. This already leads to multiple care-network-platforms that a practitioner has to use, in addition to the EHR. Switching between different applications decreases productivity and practitioner-satisfaction. Using multiple (collaboration) systems also create new silo's of disconnected medical data for a patient.

Shared Care Planning (SCP) provides the structures and transactions for care
planning, collaboration between practitioners by cross-organizational ordering processes and localization and authorization of members involved in the careteam of a patient. Improved collaboration between different types of care providers (e.g. GP, homecare or hospitals) should improve efficiency in hybrid or network-care settings. It should lower the administrative burden for practitioners without having to switch to auxillary collaboration-systems.


### Organization of this Implementation Guide

- [Overview](./overview.html): This provides an overview of the spec. It includes:
    - [Concepts](./overview.html#concepts) that are used or referred to
    - [Actors](./overview.html#actors) that can or should be capable of doing transactions
    - [Transactions](./overview.html#transactions) that actors can or should execute
    - [Security considerations](./overview.html#security-considerations)
    - [Deployment considerations](./overview.html#deployment-considerations)
    - [Use Cases/Examples](./overview.html#usecases)
    - [Comparison to related standards](./overview.html#related-standards) like referral and care coordination standards

Some of these items are explained in more detail: 

- Security considerations
  - [Authentication](authentication.html)
  - [Authorization](authorization.html)
  - [Privacy](privacy.html)

- Transactions
    - [Creating and responding to a Task](./transaction-task-negotiation.html)
    - [Updating CarePlan and CareTeam](./transaction-careplan-careteam-mngt.html)
    - [Getting data from CareTeam members](./transaction-discovery.html)


- Use Cases/Examples

    - [Enroll patient in home monitoring](./usecase-enrollment.html)
    - [Get data for home monitoring](./usecase-view-all-data.html)
    - [Referral/Nursing handoff](./usecase-nursing-handoff.html)

- [Artifacts](./artifacts.html): a comprehensive list of all artifacts that are used in SCP 

- [Changes & Issues](history.html)


### Glossary
- Personally Identifiable Information (PII) 
- Protected Health Information (PHI)
- FHIR
- HL7
- IHE



### Conformance Expectations

SCP uses the normative words: Shall, Should, and May according to standards conventions. 
SCP uses the HL7 FHIR standaard, version R4

> [!NOTE]
> It is recommended that readers have a foundational understanding of FHIR R4 to fully grasp the content presented in this document. 



<!-- add other conventions -->

### Download 

You can also download:

* [this entire guide](full-ig.zip),
* the definition resources in [json](definitions.json.zip), [xml](definitions.xml.zip), [ttl](definitions.ttl.zip), or [csv](csvs.zip) format, or
* the example resources in [json](examples.json.zip), [xml](examples.xml.zip) or [ttl](examples.ttl.zip) format.
