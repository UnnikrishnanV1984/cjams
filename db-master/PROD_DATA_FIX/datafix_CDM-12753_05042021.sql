-- CDM-12753 Void placement
/*
-- Issue Description: 
	User request to remove the placement End date to Void the placement
   
	Case ID: 3120466 - patricia.ferguson@maryland.gov
	Client ID: 1695348 (DAE'SHAWN AMARI NAJA	JEFFERS) - 656ef7d9-d2d0-494d-be72-4485ed06f442
	Placement ID: 1557684 - 2019-10-04 to 2019-10-22 - 249808ec-4444-46a6-b239-aa1e543a1000
	Private Organization : 5001618 (MENTOR Maryland, Inc.)
	CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
	Contract Program: 2810 (SED Mentor Maryland) - 2006-07-01 to 2021-06-30
    
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
where placementid = '249808ec-4444-46a6-b239-aa1e543a1000'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-12753'
where placementid = '249808ec-4444-46a6-b239-aa1e543a1000'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '249808ec-4444-46a6-b239-aa1e543a1000' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-12753'
where placementid = '249808ec-4444-46a6-b239-aa1e543a1000' 
	and exitdate is not null ;
	
