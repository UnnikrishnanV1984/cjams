
/*
-- Issue Description: 
   User request to remove the child removal end date,OOH program assignment end date, Provider Placement Exit Type, Exit Date and Exit Time.  


-- CDM-35349 - Need to create an adoption case
-- Case ID: 3150396
-- Client ID: 1939600 (ORIANNA CARMEL AMIR-PETERMAN) - b8344567-551c-4b85-a4ad-e9e8425be696

-- Placement ID: 225446 - 2009-05-01 To 2009-06-11 - 9f79e63c-d194-47d8-8c3c-bbefa86463d5
-- Living Arrangement: Biological Parent

-- Removal ID: 103217 - 2007-08-24 To 2009-06-11 - 9541b3f5-56d0-41a7-afe4-eaa65ab4013c
-- OOH: cccd1336-4e57-48d6-8641-11f06b18e6b3 - 2007-08-24 To 2009-06-11 

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Placement / Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the child removal end date,OOH program assignment end date, Provider Placement Exit Type, Exit Date and Exit Time.
-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '9f79e63c-d194-47d8-8c3c-bbefa86463d5'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-35349'
where placementid = '9f79e63c-d194-47d8-8c3c-bbefa86463d5'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '9f79e63c-d194-47d8-8c3c-bbefa86463d5'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-35349'
where placementid = '9f79e63c-d194-47d8-8c3c-bbefa86463d5'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 103217
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	 returntransts = NULL,
	removalexitreason = NULL,
	updatedby = 'CDM-35349',
	updatedon = now()
where removalid = 103217
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'cccd1336-4e57-48d6-8641-11f06b18e6b3'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-35349',
	updatedon = now()
where personprogramid = 'cccd1336-4e57-48d6-8641-11f06b18e6b3'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  103217
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-35349',
	update_ts = now()
where removal_id =  103217
	and delete_sw = 'N' ;