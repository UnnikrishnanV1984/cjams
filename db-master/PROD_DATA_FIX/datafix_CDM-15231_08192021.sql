-- CDM-15231 - Provider
/*
-- Issue Description: 
   The Worker selected the wrong Provider for GAP.
   
-- Case ID: 3289387 
-- Client ID: 3968794 (RICHARD A JACKSON) - 0de2cf41-6c68-421d-9614-1d2315494fd2
-- GAP ID: 1005701 - 8/19/2021 to 3/27/2027 - b559b8c1-9f41-42ad-9966-8b95e805675d
-- Correct Provider ID: 6001756	(TAMEKA S WILSON) - Local Department Home
-- Current Provider ID: 5000487	(Arrow Child & Family - CPA TFC Baltimore)- CPA Office 

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Info
select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey,
	updatedby, updatedon
from guardianship 
where gapid = 'b559b8c1-9f41-42ad-9966-8b95e805675d'
and activeflag = 1 ;

update guardianship 
set guardianonename = 'TAMEKA WILSON',
	guardianoneid = 510508, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6001756,
	primaryrelationshipkey = 'guardian',
	guardiantwoname = NULL,
	guardiantwoid = NULL,
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-15231',
	updatedon = now()
where gapid = 'b559b8c1-9f41-42ad-9966-8b95e805675d'
and activeflag = 1 ;




