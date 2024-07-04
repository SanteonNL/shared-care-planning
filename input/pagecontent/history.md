[09:49] Joost Holslag (Unverified)
dit gaat uit van eenmalige tasks? Veel care plan tasks zijn continu: bijv: "bel mij als de bloeddruk boven de 180 is." hoe wordt dat onderstuend?
 
[09:49] Jorrit Spee | Zorg bij jou
Joost Holslag (Unverified)
Hoe verhoudt de care plan role e.g. "contributor" zich tot de functie van een zorgprofessional: e.g. "fysiotherapeut".

Die kan afwijken. De ParticipantRole is de rol in de context van dat CarePlan, die Taak.

De functie is 'vast' voor een bepaald persoon/werkverband.
Poging tot voorbeeld: Iemand met de functie "Psychiater" kan als ParticipantRole "Hoofdbehandelaar" hebben.
 
[09:50] Joost Holslag (Unverified)
Jorrit Spee | Zorg bij jou (Unverified)
Die kan afwijken. De ParticipantRole is de rol in de context van dat CarePlan, die Taak.    De functie is 'vast' voor een bepaald persoon/werkverband.  Poging tot voorbeeld: Iemand met de functie "Psychiater" kan als ParticipantRole "Hoofdbehandelaar" hebben.

Hoe zie je die functie terug als je het care plan bekijkt?

 
[09:51] Jorrit Spee | Zorg bij jou
Joost Holslag (Unverified)
Hoe zie je die functie terug als je het care plan bekijkt?

In een VC/VP gekoppeld aan access token van request. Zeg maar de reguliere nuts-flow.

 
[09:52] Jorrit Spee | Zorg bij jou
Joost Holslag (Unverified)
dit gaat uit van eenmalige tasks? Veel care plan tasks zijn continu: bijv: "bel mij als de bloeddruk boven de 180 is." hoe wordt dat onderstuend?

deze denk ik even plenair bespreken.

 
[09:53] Joost Holslag (Unverified)
de betekenis van 'accepted' is dus meer een technische leesbevestiging?
 
[09:53] Joost Holslag (Unverified)
Het impliceert ook een acceptatie van de medische verantwoordellijkheid. dat zou ik expliciet uitgesloten zien in de specificatie.
 
[09:54] Joost Holslag (Unverified)
Jorrit Spee | Zorg bij jou (Unverified)
deze denk ik even plenair bespreken.
Bram Wesselo | Santeon (Unverified) (a)

 
[09:54] Jorrit Spee | Zorg bij jou
Ik denk dat we even moeten stilstaan bij het verschil tussen Request-resources en Tasks.
 
[09:55] Joost Holslag (Unverified)
Jorrit Spee | Zorg bij jou (Unverified)
In een VC/VP gekoppeld aan access token van request. Zeg maar de reguliere nuts-flow.

Dat voelt vreemd, dat is informatie die erg interessant is voor de lezer van een care team resource. ook relevant voor autorisatie.

 
[09:57] Joost Holslag (Unverified)
als de technische acceptatie van de task betekenis heeft in de zin van een behandelrelatie, verwacht ik toch dat je een handmatige beoordeling wilt doen. Je kunt namelijk vervolgens niet zomaar meer van een behandelrelatie af.
 
[10:01] Joris  Scharp | Zorg bij jou
ik moet helaas weg 
 
[10:01] Brussaard, Frank (External)
ik moet er helaas vandoor; tot de volgende!
 
[10:02] Jorrit Spee | Zorg bij jou
Joost Holslag (Unverified)
dit gaat uit van eenmalige tasks? Veel care plan tasks zijn continu: bijv: "bel mij als de bloeddruk boven de 180 is." hoe wordt dat onderstuend?

bump

 
[10:02] 
Vincent van den Berg (Unverified) no longer has access to the chat.

 
[10:04] Jorrit Spee | Zorg bij jou
Ik moet 4 minuten geleden naar een andere meeting. Tot de volgende en praat in de tussentijd vooral gezellig mee in kanaal #shared-care-planning ni de Nuts slack!
 
[10:16] Rein Krul | Zorg bij jou
Ik moet door, tot later 
 
[10:17] Joost Holslag (Unverified)
Ik ben het wel eens met je boodschap, dat je eindgebruikers (patienten en zorgverleners) moet betrekken. Ik maakte alleen bezwaar tegen de stelligheid van je uitspraken als: de huisarts is niet betrokken bij een bevalling.
 
[10:19] Edwin (Formelio) (Unverified)
Ik moet ook naar een volgende meeting, ik zal de recording terugkijken en kom terug met wat vragen. Erg blij met de implementation guide
 
[10:19] 
Edwin (Formelio) (Unverified) no longer has access to the chat.

 
[10:19] Bram Wesselo
Agenda:

Toelichting (SCP) FHIR Implementation Guide
Demo patient-aanmelding d.m.v. ORCA (Open-source Referentie implementatie shared CAre planning)
Voorleggen van ontwerp-keuzes:
Alle transacties worden door een gebruiker gestart (in naam van een gebruiker uitgevoerd)
Door Task-request van een Careplan-contributor en Task-acceptance van een nieuwe/andere zorgorganisatie kan deze organisatie ook Careplan-contributor worden. Om inzage in deze Tasks simpel te houden, 'leven' alle Tasks bij de CarePlan-service.
De CarePlan-service wordt altijd onder verantwoordelijkheid van een zorgorganisatie gehost om b.v. complexiteit omtrent BSN-pseudonimisatie te voorkomen.
Task-acceptance/rejection (bij een nieuwe/andere zorgorganisatie) zou direct/real-time moeten kunnen plaatsvinden. Hierdoor kan Task-aanvrager (een zorgverlener, samen met patient) direct een aanvraag naar een volgende partij sturen als de eerste de Task afwijst. Task-aanvrager kan hierdoor ook (na Task-acceptance van andere partij) gevoelige informatie sturen (push).
 
 
[10:22] Joost Holslag (Unverified)
Bram Wesselo | Santeon (Unverified)
Agenda:       Toelichting (SCP) FHIR Implementation GuideDemo patient-aanmelding d.m.v. ORCA (Open-source Referentie implementatie shared CAre planning)Voorleggen van ontwerp-keuzes:Alle transacties worden door een gebruiker gestart (in naam van een gebruiker uitgevoerd)Door Task-request van een Ca…

"Alle transacties worden door een gebruiker gestart (in naam van een gebruiker uitgevoerd)"

Hoe ga je om met technische updates/migraties?
 
[10:22] Joost Holslag (Unverified)
"Om inzage in deze Tasks simpel te houden, 'leven' alle Tasks bij de CarePlan-service."
Hoe doe je dat met bewaarplicht? 
 
[10:26] Joost Holslag (Unverified)
Bram Wesselo | Santeon (Unverified)
Agenda:       Toelichting (SCP) FHIR Implementation GuideDemo patient-aanmelding d.m.v. ORCA (Open-source Referentie implementatie shared CAre planning)Voorleggen van ontwerp-keuzes:Alle transacties worden door een gebruiker gestart (in naam van een gebruiker uitgevoerd)Door Task-request van een Ca…

"De CarePlan-service wordt altijd onder verantwoordelijkheid van een zorgorganisatie gehost"

Hoe doe je dat met zorgverleners die niet met BSN mogen werken? (sociaal domein, mantelzorgers)
 

 
[10:28] Joost Holslag (Unverified)
hoe kun je verantwoordelijk zijn voor de inhoud van een care plan dat niet onder jouw verantwoordlelijkheid gehost wordt?