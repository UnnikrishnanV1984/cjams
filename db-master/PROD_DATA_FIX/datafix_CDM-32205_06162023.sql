-- CDM-32205 - Removal
/*
-- Issue Description: 
   User reuest to fix the Child Removals / OOHs (ACQI reports priority)  

-- Case ID: 221030017064 - 71b9fc4f-613e-419c-89b7-8a259790311f
-- Client ID: 4420072 (MATTHEW JENKINS) - 71564287-66ca-4c5b-b398-f1732a6f3dc0

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to fix the Child Removal & OOH as requetsed by the user   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- placement
-- Update intakeservreqchildremovalid as '56252dad-6aa3-48fd-b0aa-0bebce4551d3' if any
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where intakeservreqchildremovalid = '055fd9e6-a867-4f32-8278-2272c287d79c'
	and activeflag = 1 ;

update cjams.placement  
set intakeservreqchildremovalid = '56252dad-6aa3-48fd-b0aa-0bebce4551d3', 
	updatedon = now(), 
	updatedby = 'CDM-32205'
where intakeservreqchildremovalid = '055fd9e6-a867-4f32-8278-2272c287d79c'
	and activeflag = 1 ;

-- Child removal
-- Delete Removal start date on 09/27/2022 - 055fd9e6-a867-4f32-8278-2272c287d79c - 254712
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 254712
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-32205',
	updatedon = now()
where removalid = 254712
	and activeflag = 1 ;
	
-- Update Removal
-- Remove the Removal End date on 09/27/2022 - 56252dad-6aa3-48fd-b0aa-0bebce4551d3 - 254359
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 254359
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-32205',
	updatedon = now()
where removalid = 254359
	and activeflag = 1 ;

-- Program Assignment
-- Delete - 3324ba13-5d6d-4fce-8210-122c15916b01	OOH	2022-09-27 00:00:00	To Current
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '3324ba13-5d6d-4fce-8210-122c15916b01'
	and activeflag = 1 ;

update cjams.personprogramarea 
set activeflag = 0, 
	updatedby = 'CDM-32205',
	updatedon = now()
where personprogramid = '3324ba13-5d6d-4fce-8210-122c15916b01'
	and activeflag = 1 ;

-- Update OOH
-- Remove the OOH PA end date 6c02d031-4b79-44f6-bb7e-3cca2b649bc9	OOH	2022-06-21 00:00:00	2022-09-27 00:00:00
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '6c02d031-4b79-44f6-bb7e-3cca2b649bc9'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-32205',
	updatedon = now()
where personprogramid = '6c02d031-4b79-44f6-bb7e-3cca2b649bc9'
	and activeflag = 1 ;
	
-- Eligibility	
-- Delete Eligibility 10005889	2022-09-27 - 254712	
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 254712
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-32205',
	update_ts = now()
where removal_id = 254712
	and delete_sw = 'N' ;
	
select eligibility_period_id, start_dt, end_dt, delete_sw, update_ts, update_user_id
	from tb_eligibility_period
where eligibility_id = 10005889
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_user_id = 'CDM-32205',
	update_ts = now()
where eligibility_id = 10005889
	and delete_sw = 'N'	;

-- Update Eligibility remove End date 10005419	2022-06-21	2022-09-27 - 254359
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 254359
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-32205',
	update_ts = now()
where removal_id = 254359
	and delete_sw = 'N' ;
