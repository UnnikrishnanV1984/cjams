-- CDM-14089 - Void Placement
/*
-- Issue Description: 
	User request to remove the placement End date so that users can Void the placement
   
-- Case ID: 2020027503338
-- Client ID: 200155623	(Stanley Lesure) - 8037ae7f-b472-45de-b51d-49e1e7cdb6ac
-- Placement ID: 1562681 - 2021-04-16 To 2021-04-19 - 48b27ad4-eea5-47a6-b3c7-89e49854ad07
-- Provider ID: 5055488 (Mary  Elzey) 
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the Closed placements.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '48b27ad4-eea5-47a6-b3c7-89e49854ad07'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-14089'
where placementid = '48b27ad4-eea5-47a6-b3c7-89e49854ad07'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '48b27ad4-eea5-47a6-b3c7-89e49854ad07' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-14089'
where placementid = '48b27ad4-eea5-47a6-b3c7-89e49854ad07' 
	and exitdate is not null ;
	
