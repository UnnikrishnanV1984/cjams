 /*
 Issue Description: 
    User request to update Child Removal End Date.  

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--No need to update placement info
	
select 	rm.removalid, rm.intakeservreqchildremovalid, rm.personid , rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
from 	intakeservreqchildremoval rm 
where 	rm.personid = '65d0ff17-dede-4b52-bd1d-fdf984931d5b' 
		and rm.removalid = 251126
		and rm.activeflag = 1 ;
	
update 	intakeservreqchildremoval rm
set 	rm.exitdate  = '2022-09-13',
		rm.updatedby = 'CDM-25151',
		rm.updatedon = now() 		
where 	rm.removalid = 251126
		and rm.personid = '65d0ff17-dede-4b52-bd1d-fdf984931d5b' 
		and rm.activeflag = 1 ;

select personprogramid, programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personid = '65d0ff17-dede-4b52-bd1d-fdf984931d5b'
	and personprogramid  = 'e9d3443e-f18a-43d5-be56-dc07b77ddb71'
	and programkey = 'OOH'
	and activeflag = 1 	;

update 	personprogramarea 
set		enddate = '2022-09-13'
where	personprogramid = 'e9d3443e-f18a-43d5-be56-dc07b77ddb71'
		and programkey = 'OOH'
		and activeflag = 1;

select 	eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw, *
from 	tb_client_eligibility 
where 	removal_id = 251126
		and delete_sw  = 'N' ;	

update 	tb_client_eligibility
set 	end_dt = '2022-09-13',
		update_user_id = 'CDM-25151',
		update_ts = now()
where 	removal_id = 251126
		and delete_sw  = 'N' ;	
