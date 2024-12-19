Instance: cps-task-signature-01-02
InstanceOf: Provenance
Usage: #example
* target = Reference(Task/{{task1id}})
* recorded = "2024-12-19T15:41:12+01:00"
* reason = $v3-ActReason#TREAT "treatment"
* activity = $v3-DataOperation#CREATE "create"
* agent.type = $provenance-participant-type#author
* insert RefIdentifier(agent.who, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, cpc1)
* insert RefIdentifier(agent.onBehalfOf, Organization, 1, $ura, URA-1, $ura, URA-1, cpc1)
* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.14 "Source Signature"
* signature.when = "2024-12-19T15:41:12+01:00"
* insert RefIdentifier(signature.who, Organization, 1, $ura, URA-1, $ura, URA-1, cpc1)
* signature.targetFormat = #application/fhir+json
* signature.sigFormat = #application/jose
* signature.data = "c29tZSBzaWduYXR1cmUgZGF0YQ=="