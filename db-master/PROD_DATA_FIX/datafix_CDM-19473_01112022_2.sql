-- CDM-19473 - Placement Date/Payment issue
/*
-- Issue Description: 
   User request to change the placement Entry Date 
   
-- Case ID: 3279843
-- Client ID: 4452678 (KOLSEN P DAVIS) - b72718cd-c118-4966-ada6-3df29086fb39
-- Placement ID: 1568996 - 2021-12-20 To Current - 58938f84-c465-442f-8fa7-1dc93750b20f	
-- Provider ID: 5093968	(Mary Faith Larrabee)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- TO update Placement Entry Time
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '58938f84-c465-442f-8fa7-1dc93750b20f'
	and activeflag  = 1 ;

update cjams.placement  
set starttime = '10:01', 
	updatedon = now(), 
	updatedby = 'CDM-19473_2'
where placementid = '58938f84-c465-442f-8fa7-1dc93750b20f'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '58938f84-c465-442f-8fa7-1dc93750b20f' ;

update cjams.placementrevision  
set entrytime = '10:01', 
	updatedon = now(), 
	updatedby = 'CDM-19473_2'
where placementid = '58938f84-c465-442f-8fa7-1dc93750b20f' ;

