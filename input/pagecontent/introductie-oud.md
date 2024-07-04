
# Oplossing

Voor de oplossing van dit probleem is vooral gekeken naar het domein van 'Patient Care Coordination'. Zowel binnen HL7.org als IHE.net zijn er diverse werkgroepen die reeds oplossingen bedacht hebben voor zorg waarbij meerdere zorgverleners/instanties (soms langdurig) betrokken zijn bij dezelfde patient en zorgvraag (zie bijvoorbeeld [IHE-Dynamic Care Planning](http://ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_DCP.pdf), [IHE-Dynamic Care Team Management](http://ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_DCTM.pdf), [HL7-Care Plan Domain Analysis Model](https://confluence.hl7.org/display/PC/Care+Plan+DAM+2.0+-+Project+Index+Page) en [HL7-Multiple Chronic Conditions](https://hl7.org/fhir/us/mcc/2023Sep/)). Binnen Nederland kennen wij ook verschillende oplossingen voor de overdracht (en/of  samenwerking) tussen zorgverleners. Bijvoorbeeld [eOverdracht](https://nuts-foundation.gitbook.io/bolts/eoverdracht/leveranciersspecificatie), [TA Notified Pull](https://www.twiin.nl/media/449/download) en [Generieke workflow](https://confluence.hl7.org/display/HNETH/Generieke%2C+transmurale+workflow) (TODO: keuze voor eerdere [FHIR Workflow pattern F](https://hl7.org/fhir/workflow-management.html#optionf) motiveren). In onderstaande oplossing is gekozen om uit te gaan van IHE-Dynamic Care Planning profile (DCP-profile), omdat deze relatief eenvoudig te combineren lijkt te zijn met de eOverdracht en TA Notified Pull. Tevens is deze  in lijn met het FHIR-besluit van VWS en (in concept zijnde) Generieke Workflow-afspraak. Het DCP-profile gaat veel verder dan het hierboven beschreven probleem; er zal daarom slechts een deel van het DCP-profile gebruikt worden binnen de hier beschreven oplossing. Als 'bijvangst' wordt er een begin gemaakt voor toekomstige verbeterslagen in de zorgcoördinatie. 
![](/input/images/overview-add-careplan.png)

![Alt text](/input/images/overview-use-careplan.png)

## Implementatie
Stel, een zorgverlener wil samenwerken met andere zorgverleners voor een bepaalde patient/zorgvraag. Hij/zij zal dan, naast de gebruikelijke verwijzing/order, ook een zorgplan en zorgteam moeten aanmaken. Deze moet in een zgn. Care Plan Service en Care Team Service staan, waar deze gevonden/opgevraagd/bewerkt kunnen worden via standaard FHIR API's (zie het IHE DCP-profile). In de praktijk kunnen deze 2 documentjes in het HIS/ECD/EPD opgeslagen worden (als die FHIR API's heeft), of bij een (externe) broker. Als er voor de patient/zorgvraag al een zorgplan/zorgteam bestaat, zal die bijgewerkt moeten worden. Het huisarts-informatie-systeem zou een logisch plek zijn voor een zorgplan en zorgteam-document, maar ook andere zorgorganisaties (verderop in de keten) kunnen deze rol vervullen.

Het zorgplan bevat de informatie over welke patient het gaat, welke zorgvraag (diagnose of vermoeden) geadresseerd wordt, welke data relevant is en welk zorgteam betrokken is. In de verwijzing/order wordt dit zorgplan genoemd, zodat een andere zorgverlener snel inzicht heeft in relevante data en het zorgteam. 
Het zorgteam geeft een opsomming van deelnemers, hun rol en welke periode ze actief zijn (geweest).  Alleen deze Care Plan/Team Service bevat het 'ware' zorgplan/zorgteam; eventuele kopieën hebben beperkte waarde. Een concreet voorbeeld van zo'n CarePlan en CareTeam kan [hier](https://hl7.org/fhir/R4/careplan-example-f203-sepsis.json.html) gevonden worden. Zie [FHIR CarePlan](https://hl7.org/fhir/R4/careplan.html), [FHIR CareTeam](https://hl7.org/fhir/R4/careteam.html) en [IHE DCP](http://ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_DCP.pdf) voor een uitgebreide beschrijving.


### Autorisatie
Iedere deelnemer in het zorgteam zou (afhankelijk van hun actieve/inactieve rol) data moeten kunnen opvragen en/of bewerken van de patient (in de context/scope van het zorgplan) bij ALLE organisaties in het zorgteam. 

Iedereen in het zorgteam kan het zorgplan aanpassen, zolang de aanpassing passend is bij de rol/taken die hij/zij heeft binnen het zorgteam/zorgplan. Dit is afhankelijk van de context en keuzes hierover kunnen per context worden vastgelegd. Een voorbeeld hiervan is de 'Zorgstandaard Integrale Geboortezorg' waarin aanpassing aan zorgteam/zorgplan worden toegekend aan de rol "coördinerend zorgverlener".
Het is aan de Care Plan/Team Service om tijdens de aanpassing (of middels een audit achteraf) te bepalen of deze 'past binnen de rol van het zorgteam-lid'. De leden van het zorgteam worden door de Care Plan/Team Service bijgewerkt; dit is een afgeleide van de uitvoerders van (lopende) activiteiten binnen het zorgplan. Er is geen aparte workflow voor deze zorgplan aanpassing (TO DO: wat bedoel je met "er is geen aparte workflow"?). Bewerking van het zorgplan/zorgteam door patient/mantelzorger zou ook mogelijk moeten zijn [TODO: hoe? PGO?? en/of clientportalen van zorgorganisaties waar de patient in zorg is].

NB: Zoals het IHE DCP ook vermeldt, kan een onderzoeker ook deel uitmaken van een zorgteam (met als rol: 'onderzoeker'). Als deze onderzoeker data opvraagt, zou deze gepseudonimiseerd teruggegeven kunnen worden door de zorgorganisatie in het zorgteam. (TO DO: apart kopje secundair gebruik/ onderzoek?)

### Datamodel
Bij een verwijzing tussen zorgorganisaties wordt ervan uit gegaan dat er een [FHIR Task](https://hl7.org/fhir/R4/task.html) uitgewisseld wordt die een referentie bevat naar het zorgplan (in Task.basedOn). Het zorgplan verwijst naar het zorgteam, patient, zorgvraag/diagnose, ondersteunende informatie en uitgevoerde/geplande taken. [TODO: plaatje maken]

### Definities
Binnen [IHE DCP](http://ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_DCP.pdf) wordt gebruik gemaakt PlanDefinition als 'template' of definitie voor een CarePlan en ActivityDefinition die vaak gebruikt wordt voor een 'template' of definitie van een Task. Deze definition-instances worden beheerd door een Care Plan Definition Service. Zo'n service kan (net als bij de Care Plan/Team Service) bestaan binnen het eigen HIS/ECD/EPD, maar kan ook door een 3e partij geleverd worden. Overeenstemming over het te volgen behandelplan kan de samenwerking in het zorgnetwerk ten goede komen. Er zou afgesproken kunnen worden welke PlanDefinition de (Nederlandse?) best-practice bevat voor een bepaalde zorgvraag of diagnose (bijvoorbeeld Diabetes type 2). Vanuit een technisch perspectief is het toepassen van interne/externe definities relatief simpel; een CarePlan of Task kan aangemaakt worden o.b.v. een PlanDefinition of ActivityDefinition. Daarna vervolgt het zorgproces met de creeerde CarePlan/Task die 'vulling' en betekenis gekregen heeft vanuit de PlanDefinition/ActivityDefinition. Bij gebruik van een externe Care Plan Definition Service zal er ook iets geregeld moeten worden in het HIS/ECD/EPD om de juiste definitie te vinden/adresseren. Voor deze specificatie is dat proces buiten scope.   



## Voorbeeld 1

Patient P meldt zich met klachten aan haar rechtervoet. Ze heeft ooit al de diagnose hypertensie gehad en slikt daar medicatie voor. Patient heeft verder een lang dossier met somatische en psychische aandoeningen. Na onderzoek stelt zorgverlener A de diagnose Diabetes Mellitus type 2 vast. In een nieuw, 'leeg' zorgplan worden de relaties vastgelegd tussen diagnose, de relevante voorgeschiedenis (hypertensie diagnose) en relevante medicatie van de patient. Ten slotte wordt er een nieuw zorgteam aangemaakt dat bestaat uit de patient en zorgverlener A. Het nieuwe zorgteam wordt geautoriseerd voor de (lokale) data van deze patient. Als er uit de anamnese blijkt dat er andere actieve, relevante behandelrelaties zijn, wordt deze data opgehaald (d.m.v. MITZ) en/of worden deze zorgverleners uitgenodigd om (alsnog) te participeren in het zorgteam; dit proces wordt in de volgende paragrafen beschreven. Dit zou de kans moeten verlagen op meerdere, redundante zorgplannen voor dezelfde zorgvraag.

![](/input/images/example1-1.png)


Zorgverlener A wil haar patient verwijzen naar een ziekenhuis B om de voet te laten amputeren. Na overleg met de patient (consent) maakt ze een verwijzing/order aan. Via een notificatie wordt deze in het ziekenhuis ontvangen.  (proces van dit soort transmurale verwijzingen/orders wordt [hier](https://confluence.hl7.org/display/HNETH/Generieke%2C+transmurale+workflow) verder beschreven).

![](/input/images/example1-2.png)

In het ziekenhuis wordt deze taak wordt toegewezen aan een lokaal ziekenhuis-team die de order accepteert. De acceptatie van de taak veroorzaakt meerdere acties:
- in ziekenhuis B wordt het **zorgteam** geautoriseerd voor de (lokale) data van deze patient 
- bij zorgorganisatie A wordt het zorgteam aangepast; er is immers een nieuwe behandelrelatie. 

Hierdoor kunnen zowel zorgverlener A als het team van chirurgen nu alle data inzien van de organisaties in het zorgteam van deze patient. Via het zorgplan vindt de chirurg verwijzingen naar data die door zorgverlener A als relevant is aangemerkt. Indien nodig kan dit aangevuld worden. 

![](/input/images/example1-3.png)


Zodra de verrichting is uitgevoerd (met een 'Procedure' als resultaat), wordt de patient verwezen naar een thuiszorg-organisatie die de revalidatie op zich zal nemen. Patient stemt hiermee in en Thuiszorg-organisatie C accepteert deze taak. Dit thuiszorg-team wordt hierdoor wederom toegevoegd aan het zorgteam zodat men snel de relevante voorgeschiedenis kan vinden. Thuiszorg-organisatie C autoriseert het zorgteam voor de lokale data van patient P. 

De revalidatie start en de rol van het chirurgisch-team is inmiddels afgerond. De autorisatie wordt hierdoor bij zorgorganisatie A en de thuiszorg-organisatie C ingeperkt (bijvoorbeeld tot de data-elementen waar zij direct bij betrokken waren; de amputatie-order, zorgplan en zorgteam). 

![](/input/images/example1-4.png)

## Transacties


### Van verwijzing tot uitvoering
[TODO: beschrijving + sequence-diagram van verwijs-proces tot uitvoering]
![Alt text](/input/images/request-to-execution.png)




### Van uitvoering tot afronding
[TODO: beschrijving + sequence-diagram van uitvoering tot afronding van taak]






 
