# Shared Care Planning

This repository contains the content of the Shared Care Planning Implementation Guide. For a readable version, start [here](https://santeonnl.github.io/shared-care-planning/).

You can also check [this slidedeck](/input/assets/Shared%20Care%20Planning%20HL7%20WGM%202024%20nov.pptx) to quickly get a feeling what Shared Care Planning is. 

This specification is in **draft status**. Feel free to **contribute** to this standard. Create a new issue or create an new branch and pull-request into main.

For questions, you can reach (original authors) Jorrit Spee and Bram Wesselo on the NUTS-Slack community: https://nuts-foundation.slack.com or find us on LinkedIn


# FHIR Implementation Guide Auto-Builder
This IG can also be build using the FHIR Implementation Guide Auto-Builder. To trigger a build, use this curl statement (change to branchname 'main' to whatever branch you're trying to build):

```
curl -X POST  "https://us-central1-fhir-org-starter-project.cloudfunctions.net/ig-commit-trigger" \
-H "Content-Type:application/json" \
--data '{"ref": "refs/heads/main", "repository": {"full_name": "santeonnl/shared-care-planning"}}'
```

The result is published on https://build.fhir.org/ig/santeonnl/shared-care-planning/branches/
In the ./build.log you can find the build log. Validation tests are in ./output/qa.html
