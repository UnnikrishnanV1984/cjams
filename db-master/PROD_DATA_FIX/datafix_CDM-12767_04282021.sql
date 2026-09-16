-- CDM-12767 - Void Placement
/*
-- Issue Description: 
	User request to remove the placement End date so that users can Void the placement
   
	Case ID: 3155734 - tiffany.palmer@maryland.gov
	Client ID: 2114318 (DAMEIAN FORTUNE TURNAGE) - 51e7a83b-e763-48b0-b2c4-5b7aa7c56cfc
	Placement ID: 336285 - 2019-07-31 to 2019-08-21 - 4b4632ec-0731-447a-b7cf-e71320c554e8
	Private Organization: 5001618 (MENTOR Maryland, Inc.)
	CPA Office: 5020914 (MENTOR Maryland - Salisbury)	
	Program ID: 2817 (Teens in Transition Baltimore Office) - 2007-06-01 to 2021-06-30

    
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
where placementid = '4b4632ec-0731-447a-b7cf-e71320c554e8'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-12767'
where placementid = '4b4632ec-0731-447a-b7cf-e71320c554e8'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '4b4632ec-0731-447a-b7cf-e71320c554e8' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-12767'
where placementid = '4b4632ec-0731-447a-b7cf-e71320c554e8' 
	and exitdate is not null ;
	
