-- CDM-16942 - End date a placement
/*
-- Issue Description: 
   User request to change the placement Exit date as 08/31/20211 (old value 08/13/2021)

-- Case ID: 3294261
-- Client ID: 4304089 (MAURICE WRIGHT) - 05e5f57a-f374-4c70-8372-000ec465064a
-- Placement ID: 1564656 - 2021-03-23 To 2021-08-13 - 6ab5be53-4002-4480-af1e-f220dd462378
-- Provider ID: 5094728 (Monique Williams) 
-- Placement Structure: Formal Kinship Care

-- Exit date change  2021-08-13 --> 2021-08-31

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the exit date.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Exit date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '6ab5be53-4002-4480-af1e-f220dd462378'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-08-31 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16942'
where placementid = '6ab5be53-4002-4480-af1e-f220dd462378'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '6ab5be53-4002-4480-af1e-f220dd462378' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-08-31 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16942'
where placementid = '6ab5be53-4002-4480-af1e-f220dd462378'
	and exitdate is not null ;
