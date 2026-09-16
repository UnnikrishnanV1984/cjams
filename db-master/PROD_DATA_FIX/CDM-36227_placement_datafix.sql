-- CDM-36227- Update Placement
/* 
-- Issue Description: 
   User request to change the placement start Date 
   Need to update the start date from 05/07/2021 09:00 AM to 10/22/2020 at 9:15 AM
   
-- Case ID: 3231006 - eb6d9c29-5883-4bed-8b7e-4ed175d73d73
-- Client ID: 4459669  (Jaxon Zeller) - 34e34ffb-ef22-4532-930f-f5b0aadc89d9
-- Placement ID: 1566471 -  b181cc48-c0d7-4a04-a14c-1799b220613a 

-- Category/ Module: Placements  (Case Management)

-- Root cause: Placement start date was not correct per user
-- Fix Provided: Datafix has been updated to update the placement start date & time 
--				 with the user provided date for the placementid 'b181cc48-c0d7-4a04-a14c-1799b220613a'
--				No match in tb_placement_validation for placement_id '1566471', so ignoring to update this table
-- Pull request# N/A
*/

-- Placement Start date & Time changes
-- 2021-05-07 00:00:00	Start Time 09:00 (current)
-- 2020-10-22 00:00:00	Start Time 09:15 (new)

select alternateid, startdatetime, starttime, personid 
	from placement 
	where placementid = 'b181cc48-c0d7-4a04-a14c-1799b220613a';

update placement 
	set startdatetime = '2020-10-22 00:00:00', 
		starttime = '09:15', 
		updatedon = now(), 
		updatedby = 'CDM-36227'
	where placementid = 'b181cc48-c0d7-4a04-a14c-1799b220613a';
	

select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
	where placementid = 'b181cc48-c0d7-4a04-a14c-1799b220613a' 
		and activeflag = 1;	

update placementrevision 
	set entrydate = '2020-10-22 00:00:00',
		entrytime = '09:15',
		updatedby = 'CDM-36227', 
		updatedon = now() 
	where placementid = 'b181cc48-c0d7-4a04-a14c-1799b220613a' 
	and activeflag = 1;


