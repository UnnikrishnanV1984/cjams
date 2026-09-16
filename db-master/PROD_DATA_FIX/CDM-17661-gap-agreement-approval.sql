/*
    Issue no: CDM-17661, CDM-17689, CDM-17660, CDM-17659, CDM-17658
    Issue description: Gap agreement rate is under review but not listed in the supervisor approval inbox
    Issue Fix: Inactivated the rows. So that user can create a new gap agreement rate and send for approval
*/

update gapagreementrate set activeflag = 0, updatedby = 'CDM-17661', updatedon = now() 
where gapagreementrateid in ('d76c0ee3-434b-482d-9c0e-494eac40b2f5', '20cf24ce-9fd8-4669-b504-54141d88cd84', '0e089bfb-ea51-463c-a2b7-bb4fa4d64b4e', '03f81411-7bcf-4e63-8bc9-874471bf3a8d', '782812d9-09d2-4e93-b4e7-ce7d977ebc60');