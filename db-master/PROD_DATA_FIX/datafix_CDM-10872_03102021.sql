-- CDM-10872 - Placement
/*
-- Issue Description: 
   User request to remove the placement End date so that users can Void the placement
   
   Client ID: 1733525 - Case ID: 3288360
   CPA Office ID: 5000970 (Pressley Ridge Baltimore)
   Placement ID: 1534015 - 07/16/2020 to 10/15/2020
   Program ID: 2667 (Pressley Ridge Caroline) - 04/16/2007 to 06/30/2021
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the placements.
		We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '31f1de8d-719a-4e48-a258-f1c36ef6d57b'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-10872'
where placementid = '31f1de8d-719a-4e48-a258-f1c36ef6d57b'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '31f1de8d-719a-4e48-a258-f1c36ef6d57b' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-10872'
where placementid = '31f1de8d-719a-4e48-a258-f1c36ef6d57b' 
	and exitdate is not null ;
	
