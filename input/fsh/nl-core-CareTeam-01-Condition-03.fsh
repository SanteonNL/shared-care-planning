Instance: nl-core-CareTeam-01-Condition-03
InstanceOf: Condition
Usage: #example
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* category = $sct#116223007 "Complicatie"
* code = $sct#62014003 "Geneesmiddel-interacties"
* subject = Reference(nl-core-Patient-01) "Patient, Johanna Petronella Maria (Jo) van Putten-van der Giessen"
* subject.type = "Patient"
* note.text = "Huiduitslag met veel jeuk door medicatie"