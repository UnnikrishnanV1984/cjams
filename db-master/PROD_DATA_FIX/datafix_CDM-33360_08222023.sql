-- CDM-33360 - Need to exit rejected placements
/*
-- Issue Description: 
   User reuest to delete 2 Rejected Provider Placements

-- Case ID: 231030051609
-- Provider ID: 6003898	(KIMBERLY  SMITH) 

-- Cleint ID: 201017994 (Collin	M Jackson) - 94d6308f-f3a2-4d95-9b06-1098015d1b75
-- Placement ID: 1606371 - 2023-01-24 To Current - 7880dde8-032f-4cdf-9208-1f640b7bdaaa

-- Cleint ID: 201017999 (Clover	J Jackson) - d23a431a-9a96-482e-b540-756eba46d5c6
-- Placement ID: 1606372 - 2023-01-24 To Current - a07d6c0f-f58c-4c97-a404-7bfc12f24f5d


-- Category/ Module: Child Placement (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to delete requested Rejected Provider Placements
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete requested Rejected Provider Placements (CDM-33360) 
select alternateid, startdatetime, starttime, enddatetime, endtime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid in ('a07d6c0f-f58c-4c97-a404-7bfc12f24f5d', '7880dde8-032f-4cdf-9208-1f640b7bdaaa')
	and activeflag = 1 ;

update cjams.placement  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33360'
where placementid in ('a07d6c0f-f58c-4c97-a404-7bfc12f24f5d', '7880dde8-032f-4cdf-9208-1f640b7bdaaa')
	and activeflag  = 1 ;

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid in ('a07d6c0f-f58c-4c97-a404-7bfc12f24f5d', '7880dde8-032f-4cdf-9208-1f640b7bdaaa')
	and activeflag  = 1 ;
		
update cjams.placementrevision  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33360'
where placementid in ('a07d6c0f-f58c-4c97-a404-7bfc12f24f5d', '7880dde8-032f-4cdf-9208-1f640b7bdaaa')
	and activeflag  = 1 ;

-- Routing
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon  
	from routing  
where objectid in ('a07d6c0f-f58c-4c97-a404-7bfc12f24f5d', '7880dde8-032f-4cdf-9208-1f640b7bdaaa')
	and eventcode = 'PLTR'
	and activeflag = 1 ;
	
update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33360'	
where objectid in ('a07d6c0f-f58c-4c97-a404-7bfc12f24f5d', '7880dde8-032f-4cdf-9208-1f640b7bdaaa')
	and eventcode = 'PLTR'
	and activeflag = 1 ;
	
-- No Data in Placement Validation table
