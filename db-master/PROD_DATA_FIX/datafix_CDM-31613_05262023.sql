-- CDM-31613 - Duplicate referral
/*
-- Issue Description: 
-- The subsidy agreement was sent twice, usre request to delete duplicate agreement request
   
-- Case ID: 3290026 - 5f8fc24b-7ec0-4e2e-944e-532359acac5d
-- Client ID: 4258495 (KALILAH IONA	HARMON) - 0a788350-a222-4ee4-b2d4-79111a529ff9
-- Provider ID: 5083357	(Megan Baker)
-- Apporved 7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe with no rate 
-- Duplicate 82b555c3-a64e-4712-ac84-54a9c935eba3 with rate 

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Duplicate Record in Adoption Agreement table & Rate is connected with one
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To delete duplicate subsidy agreement request (CDM-31613)
-- adoptionagreementid: 82b555c3-a64e-4712-ac84-54a9c935eba3
select adoptionplanningid, activeflag, updatedby, updatedon 
from adoptionagreement 
where adoptionagreementid  = '82b555c3-a64e-4712-ac84-54a9c935eba3'
	and activeflag = 1 ;
 
update adoptionagreement
set activeflag = 0, 	
	updatedby = 'CDM-31613',
	updatedon = now()
where adoptionagreementid  = '82b555c3-a64e-4712-ac84-54a9c935eba3'
	and activeflag = 1 ;
	
select routingstatustypeid, remarks,  activeflag, updatedby, updatedon, * 
	from routing 
where objectid = '82b555c3-a64e-4712-ac84-54a9c935eba3'
	and eventcode = 'ASAR'
	and activeflag = 1 ;
	
update routing
set activeflag = 0, 	
	updatedby = 'CDM-31613',
	updatedon = now()
where objectid = '82b555c3-a64e-4712-ac84-54a9c935eba3'
	and eventcode = 'ASAR'
	and activeflag = 1 ;

	
-- Update adoptionagreementid on the Subsidy Rate 
-- adoptionagreementid: 7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe (old value 82b555c3-a64e-4712-ac84-54a9c935eba3)
select activeflag, adoptionagreementid, activeflag, updatedby, updatedon
	from adoptionagreementrate   
where adoptionagreementrateid = '8ea12408-dcdc-4b43-8300-f494d2891607' 
	and activeflag = 1 ;

update adoptionagreementrate
set adoptionagreementid = '7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe', 	
	updatedby = 'CDM-31613',
	updatedon = now()
where adoptionagreementrateid = '8ea12408-dcdc-4b43-8300-f494d2891607' 
	and activeflag = 1 ;

select activeflag, adoptionagreementid, activeflag, updatedby, updatedon
	from adoptionagreementraterevision   
where adoptionagreementrateid = '8ea12408-dcdc-4b43-8300-f494d2891607';

update adoptionagreementraterevision
set adoptionagreementid = '7d1a7cb9-1362-44e7-83e9-40fe3f45dcbe', 	
	updatedby = 'CDM-31613',
	updatedon = now()
where adoptionagreementrateid = '8ea12408-dcdc-4b43-8300-f494d2891607';

