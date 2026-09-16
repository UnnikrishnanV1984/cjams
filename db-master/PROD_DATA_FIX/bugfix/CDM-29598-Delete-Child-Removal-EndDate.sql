/*
-- Issue Description: 
	CDM-29598 : Issue with Breaking the Link
	QA/BA:  remove the removal end date for client ID # 200770823 (Chance Brady) 
			so the user can void the incorrect placement structure and create a new placement with the right placement structure.
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/
select 	removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
from 	cjams.intakeservreqchildremoval
where 	removalid = 252494 and activeflag = 1 ;
	
update 	cjams.intakeservreqchildremoval
set 	exitdate = Null,
		returndate = Null,
		returntime = Null,
		removalexitreason = NULL,
		updatedby = 'CDM-29598',
		updatedon = now()
where 	removalid = 252494 and activeflag = 1 ;
	
-- Update OOH
select 	programkey, startdate, enddate, updatedby, updatedon
from 	cjams.personprogramarea 
where 	personprogramid = '4d3b579b-eb84-455c-b879-adbd7a4201bd' and activeflag = 1 ;

update 	cjams.personprogramarea 
set 	enddate = Null, 
		updatedby = 'CDM-29598',
		updatedon = now()
where 	personprogramid = '4d3b579b-eb84-455c-b879-adbd7a4201bd' 	and activeflag = 1 ;
	
-- Update Eligibility
select 	removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
from 	cjams.tb_client_eligibility
where 	removal_id =  252494	and delete_sw = 'N' ;

update 	cjams.tb_client_eligibility
set 	end_dt = Null,
		update_user_id = 'CDM-29598',
		update_ts = now()
where 	removal_id =  252494 and delete_sw = 'N' ;