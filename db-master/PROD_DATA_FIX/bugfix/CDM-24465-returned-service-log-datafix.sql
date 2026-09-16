-- CDM-24465 - Returned Service Log
/*
-- Issue Description: 
   User reuested to update the Child Removal End Date   
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update enddate the Removal, OOH & IV-E
-- Update Removal
select 	removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag, personid
from 	cjams.intakeservreqchildremoval
where 	removalid = 177433
		and activeflag = 1 ;
	
update 	cjams.intakeservreqchildremoval
set 	exitdate = '2022-06-20 00:00:00',
		updatedby = 'CDM-24465',
		updatedon = now()
where 	removalid = 177433
		and activeflag = 1 ;
	
-- Update OOH
select 	programkey, startdate, enddate, updatedby, updatedon, *
from 	cjams.personprogramarea 
where 	personid = '33d5afcf-55a9-450d-bf2b-8558ab348008' and programkey = 'OOH'
		and personprogramid = 'c3191137-b003-4a66-80e8-dad6d9361511' and activeflag = 1 ;

update 	cjams.personprogramarea 
set 	enddate = '2022-06-20 00:00:00', 
		updatedby = 'CDM-24465',
		updatedon = now()
where 	personid = '33d5afcf-55a9-450d-bf2b-8558ab348008' and programkey = 'OOH'
		and personprogramid = 'c3191137-b003-4a66-80e8-dad6d9361511' and activeflag = 1 ;
	
-- Update Eligibility
select 	removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
from 	cjams.tb_client_eligibility
where 	removal_id =  177433
		and delete_sw = 'N' ;

update 	cjams.tb_client_eligibility
set 	end_dt = '2022-06-20 00:00:00',
		update_user_id = 'CDM-24465',
		update_ts = now()
where 	removal_id =  177433
		and delete_sw = 'N' ;