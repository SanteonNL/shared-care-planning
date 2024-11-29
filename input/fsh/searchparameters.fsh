Instance: CarePlan-subject-identifier
InstanceOf: SearchParameter
Usage: #definition
* url = "http://santeonnl.github.io/shared-care-planning/cps-searchparameter-careplan-subject-identifier.json"
* name = "subject-identifier"
* status = #active
* description = "Search CarePlans by subject identifier"
* code = #subject-identifier
* base = #CarePlan
* type = #token
* expression = "CarePlan.subject.identifier"
* xpathUsage = #normal
* xpath = "f:CarePlan/f:subject/f:identifier"

Instance: Task-input-reference
InstanceOf: SearchParameter
Usage: #definition
* url = "http://santeonnl.github.io/shared-care-planning/cps-searchparameter-task-input-reference.json"
* name = "input-reference"
* status = #active
* description = "Search Tasks by input references and include inputs when searching Tasks"
* code = #input-reference
* base = #Task
* type = #reference
* expression = "Task.input.value.ofType(Reference)"
* xpathUsage = #normal
* xpath = "f:Task/f:input/f:valueReference"

Instance: Task-output-reference
InstanceOf: SearchParameter
Usage: #definition
* url = "http://santeonnl.github.io/shared-care-planning/cps-searchparameter-task-output-reference.json"
* name = "output-reference"
* status = #active
* description = "Search Tasks by output references and include outputs when searching Tasks"
* code = #output-reference
* base = #Task
* type = #reference
* expression = "Task.output.value.ofType(Reference)"
* xpathUsage = #normal
* xpath = "f:Task/f:output/f:valueReference"