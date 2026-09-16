-- CDM-13993 - VOIDED PLACEMENTS
/*
-- Issue Description: 
   User request to remove the placement End dates so that users can Void the placements
   
-- Case ID: 3231884
-- Client ID: 3585472 (REAGAN RIVERS) - 145bf514-9850-4da9-83d0-37906f94041a

-- Placement ID: 1562298 - 2021-04-06 To 2021-05-21 - 2b7ee25c-88dd-4c26-a12d-451e1e029d81
-- Private Organization: 5001252 (PSI Services, Inc.)	
-- CPA Office: 5001594 (PSI Services TFC)
-- Program ID: 1371	(TFC-PSI Services) - 2006-07-01 To 2021-06-30
	
-- Placement ID: 1561625 - 2021-03-22 To 2021-04-06 - 60979d22-4350-4111-bb5d-b5e3c431f25b
-- Private Organization: 5001618 (MENTOR Maryland, Inc.)
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Program ID: 1545	(Medically Complex TFC- Mentor) - 2006-07-01 To 2021-06-30
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the placements.
			   We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement ID: 1562298 - 2021-04-06 To 2021-05-21 - 2b7ee25c-88dd-4c26-a12d-451e1e029d81
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '2b7ee25c-88dd-4c26-a12d-451e1e029d81'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13993'
where placementid = '2b7ee25c-88dd-4c26-a12d-451e1e029d81'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '2b7ee25c-88dd-4c26-a12d-451e1e029d81' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13993'
where placementid = '2b7ee25c-88dd-4c26-a12d-451e1e029d81' 
	and exitdate is not null ;
	
	
-- Placement ID: 1561625 - 2021-03-22 To 2021-04-06 - 60979d22-4350-4111-bb5d-b5e3c431f25b	
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '60979d22-4350-4111-bb5d-b5e3c431f25b'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13993'
where placementid = '60979d22-4350-4111-bb5d-b5e3c431f25b'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '60979d22-4350-4111-bb5d-b5e3c431f25b' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13993'
where placementid = '60979d22-4350-4111-bb5d-b5e3c431f25b' 
	and exitdate is not null ;
