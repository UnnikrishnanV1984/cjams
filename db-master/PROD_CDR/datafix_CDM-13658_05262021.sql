-- CDM-13658 - Void placement
/*
-- Issue Description: 
	User request to remove the placement End date so that users can Void the placement
   
-- Case ID: 3276610 
-- Client ID: 3581727 (LANELL SMITH) - fc999d2a-b179-42ee-b0b8-fdb27c87984a
-- Placement ID: 1563269 - 2021-05-19 To 2021-05-24 - 902cdb05-ec5f-48e0-895c-c89879277744
-- Private Organization: 5001252 (PSI Services, Inc.)
-- CPA Office: 5001594 (PSI Services TFC)
-- Program ID: 1371	(TFC-PSI Services) - 2006-07-01 To 2021-06-30 

    
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
where placementid = '902cdb05-ec5f-48e0-895c-c89879277744'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13658'
where placementid = '902cdb05-ec5f-48e0-895c-c89879277744'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '902cdb05-ec5f-48e0-895c-c89879277744' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13658'
where placementid = '902cdb05-ec5f-48e0-895c-c89879277744' 
	and exitdate is not null ;
	