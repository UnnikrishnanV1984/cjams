-- CDM-31927 - Removal and placement ended in error
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3234059
-- Client ID: 3616407 (LUKIS HENRY BORCK) - 26e4b208-103d-43eb-bc49-1842129859b1

-- Placement ID: 1574323 - 2022-08-16 To 2023-05-12 - 7c9bfe9b-38b9-4f95-8bf8-512fda433026
-- Living Arrangement: Relative/fictive kin home

-- Removal ID: 188409 - 2017-12-18 To 2023-05-12 - c4750db0-0e1c-454b-80b1-7c406caa2ad9
-- OOH: 29d0f2e6-281d-44f8-9623-f709c23d9844 - 2017-12-18 To 2023-05-12 

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Placement / Child Removal / OOH   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E
-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '7c9bfe9b-38b9-4f95-8bf8-512fda433026'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-31927'
where placementid = '7c9bfe9b-38b9-4f95-8bf8-512fda433026'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '7c9bfe9b-38b9-4f95-8bf8-512fda433026'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-31927'
where placementid = '7c9bfe9b-38b9-4f95-8bf8-512fda433026'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 188409
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-31927',
	updatedon = now()
where removalid = 188409
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '29d0f2e6-281d-44f8-9623-f709c23d9844'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-31927',
	updatedon = now()
where personprogramid = '29d0f2e6-281d-44f8-9623-f709c23d9844'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  188409
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-31927',
	update_ts = now()
where removal_id =  188409
	and delete_sw = 'N' ;
