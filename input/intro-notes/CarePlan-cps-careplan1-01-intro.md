### Intro

Before creating a CarePlan, search for an existing one at the CarePlanService. Such a query would look like this, assuming the access_token will provide search-narrowing for a single Patient:

```
curl <fhir-base-url>CarePlan?category=http://snomed.info/sct|135411000146103
```