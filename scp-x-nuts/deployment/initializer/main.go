package main

import (
	"github.com/SanteonNL/shared-care-planning/scp-x-nuts/careteamservice/fhir"
	"github.com/SanteonNL/shared-care-planning/scp-x-nuts/careteamservice/nuts"
)

func main() {
	fhir.Initialize()
	nuts.Initialize("Huisartsenpraktijk de Vries", "Ziekenhuis Maas en Waal", "Thuiszorg KomThuus")
}
