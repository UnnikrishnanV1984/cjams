-- CDM-32280 - placement needs to remain open
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3301062
-- Client ID: 4432882 (JENETTA APPEL) - 467428d6-b95e-474d-83da-16d137e6572a
-- Placement ID: 1575807 - 2022-10-20 To 2023-05-16 - 4aa065cc-9fe7-45aa-a9aa-27524a8f8cc3
-- Provider ID: 5091761	(Donna Ayres) 
-- Child Removal ID: 252117	- 2021-05-28 To 2023-05-16 - 8fb116c2-630b-4712-ab87-b3afe1a1a386
-- OOH - 2021-05-28 To 2023-05-16 - e514bfa7-3f51-4a7c-b10d-9fc3fab00407

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
where placementid = '4aa065cc-9fe7-45aa-a9aa-27524a8f8cc3'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-32280'
where placementid = '4aa065cc-9fe7-45aa-a9aa-27524a8f8cc3'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '4aa065cc-9fe7-45aa-a9aa-27524a8f8cc3'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-32280'
where placementid = '4aa065cc-9fe7-45aa-a9aa-27524a8f8cc3'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252117
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-32280',
	updatedon = now()
where removalid = 252117
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'e514bfa7-3f51-4a7c-b10d-9fc3fab00407'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-32280',
	updatedon = now()
where personprogramid = 'e514bfa7-3f51-4a7c-b10d-9fc3fab00407'
	and activeflag = 1 ;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  252117
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-32280',
	update_ts = now()
where removal_id =  252117
	and delete_sw = 'N' ;
