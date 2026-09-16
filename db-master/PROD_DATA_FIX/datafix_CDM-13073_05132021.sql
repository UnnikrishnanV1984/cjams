-- CDM-13073 - Exit Date Incorrect
/*
-- Issue Description: 
	User request to remove the placement End date so that users can Void the placement
   
-- Case ID: 3284493 - lindsay.newcomb1@maryland.gov
-- Client ID: 3626537 (SKYLA M SCHOLZ) - 77119316-173c-4e6c-ac5a-5b90476518da
-- Placement ID: 1562190 - 2020-08-05 To 2021-04-30 - af99b536-f036-4bff-bba7-e775adbd2c2d
-- Private Organization: 5019111 (Devereux Foundation)
-- RCC Facility: 5022283 (Devereux Florida)
-- Program ID: 50002271 (Skyla Scholz) - 2020-08-05 To 2022-02-28 
-- Structure: 76 (Residential Treatment Centers) 
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the placements.
			   We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'af99b536-f036-4bff-bba7-e775adbd2c2d'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13073'
where placementid = 'af99b536-f036-4bff-bba7-e775adbd2c2d'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'af99b536-f036-4bff-bba7-e775adbd2c2d' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13073'
where placementid = 'af99b536-f036-4bff-bba7-e775adbd2c2d' 
	and exitdate is not null ;
	
