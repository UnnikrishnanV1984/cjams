-- CDM-17684 - Placement
/*
-- Issue Description: 
   User request to update the Provider info on below to migrated placements 
   for Title IV-E Eligibility Determination

-- Case ID: 3102581
-- Client ID: 1716486 (SHAMAR SHABAZZ BRISCOE) - 6a9cbdc5-d83e-48be-8b60-815c6b92f985
-- Provider ID: 5015242	(Elendia Worthington) - Local Department Home
-- Placements
-- ID: 158000 - 2006-02-10 To 2006-12-31 - f9656f4b-da09-4529-a498-543da304766c
-- ID: 157999 - 2005-10-20 To 2006-02-10 - 58a7cabf-4151-49c5-a404-5ee4c28cf434

-- Category/ Module: Placements  (Case Management) 
-- Root cause:  Exception scenario (Migrated data limitation)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement Exit date changes
select placementid, placementtypekey, altproviderid, providerid, startdatetime, enddatetime, 
	updatedby, updatedon
from placement 
where alternateid in (158000, 157999) 
	and activeflag = 1 ;

update placement  
set placementtypekey = 'PRPL', 
	altproviderid = 5015242,
	providerid = '9b687cbb-a40c-4582-8498-09a6d5ece263',
	updatedon = now(), 
	updatedby = 'CDM-17684'
where alternateid in (158000, 157999) 
	and activeflag = 1 ;
	
