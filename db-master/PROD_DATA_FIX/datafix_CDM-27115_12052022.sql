-- CDM-27115 - Placement end date needs removed
/*
-- Issue Description: 
   User reuest to re-open the Placement 

-- Case ID: 3063821
-- Client ID: 3294671 (MARISOL ABIGAIL GARCIA) - 46b618f2-0bde-43da-b2ae-8b6763257c54
-- Provider ID: 5091761 (Donna Ayres) - Local Department Home
-- Placement ID: 1558108 - 2020-08-08 To 2022-10-04 - e6325702-91dc-4330-926a-94f8a2de500c

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement
-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'e6325702-91dc-4330-926a-94f8a2de500c'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-27115'
where placementid = 'e6325702-91dc-4330-926a-94f8a2de500c'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'e6325702-91dc-4330-926a-94f8a2de500c'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-27115'
where placementid = 'e6325702-91dc-4330-926a-94f8a2de500c'
	and ( exitdate is not null or exittime is not null ) ;
	