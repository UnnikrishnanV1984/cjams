/*
   Issue Description: CDM-25084
   Category/ Module  : User asked to end OOH with 06/15/2022
   Root cause: user wants to end OOH with 06/15/2022
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

select 	rm.removalid, rm.intakeservreqchildremovalid, rm.personid , rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
from 	intakeservreqchildremoval rm 
where 	rm.personid = 'a8cca2bc-18d2-489b-b4d8-0adbe2a5bf13' 
		and rm.removalid = 254149
		and rm.activeflag = 1;
	
update 	intakeservreqchildremoval rm
set 	rm.exitdate = '2022-06-15',
		rm.updatedby = 'CDM-25084',
		rm.updatedon = now() 		
where 	rm.personid = 'a8cca2bc-18d2-489b-b4d8-0adbe2a5bf13' 
		and rm.removalid = 254149
		and rm.activeflag = 1;
		
select 	personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
from 	personprogramarea 
where 	personid = 'a8cca2bc-18d2-489b-b4d8-0adbe2a5bf13'
		and personprogramid  = 'dbdf7d30-a307-4157-b668-ae9f5d0e80ca'
		and programkey = 'OOH'
		and activeflag = 1;

update	personprogramarea
set		enddate = '2022-06-15',
		updatedon = now(),
		updatedby  = 'CDM-25084'
where 	personid = 'a8cca2bc-18d2-489b-b4d8-0adbe2a5bf13'
		and personprogramid  = 'dbdf7d30-a307-4157-b668-ae9f5d0e80ca'
		and programkey = 'OOH'
		and activeflag = 1;

select 	eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw , end_dt
from 	tb_client_eligibility 
where 	removal_id = 254149
		and eligibility_status_cd = '2909'
		and delete_sw  = 'N';	

update 	tb_client_eligibility
set 	end_dt = '2022-06-15',
		update_user_id = 'CDM-25084',
		update_ts = now()
where 	removal_id = 254149
		and eligibility_status_cd = '2909'
		and delete_sw  = 'N';	