/*
File Name: CDM-27961
-- Issue Description: 
   Connected and screen share with the user, found out that there are two history removal record for Dylan Ray Doerr (CJAMS PID# : 2263283).
Please do the data fix as below:

1. Closed the case # 3162377 and remove the Reopen record from the Decision tab.
2. Ended the Child Removal for case # 3162377 with 9/27/2019 as highlighted.
-- Resolution: Updated the activeflag to zero in the routing table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	intakeservreqchildremoval
set
	exitdate = '2019-09-27 12:00:00',
	returndate = '2019-09-27 12:00:00',
	returntime = '2019-09-27 12:00:00',
	updatedby = 'CDM-27961', updatedon = now()
where
	intakeservreqchildremovalid = 'bc023962-7290-49df-aa9a-744a2f158753';

update cjams.servicecasedisposition 
set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-27961'
where servicecasedispositionid='d4a01e53-20b3-45cc-a0f6-eb384e453635';

update tb_client_eligibility 
set
end_dt='2019-09-27 12:00:00',
update_ts = now(),
update_user_id = 'CDM-27961'
where case_id='3162377' and removal_id='183776';

--OOH assignment need to be ended with date with 9/27/2019
update personprogramarea set enddate = '2019-09-27 00:00:00', updatedby = 'CDM-27961', updatedon = now() 
where personprogramid = '6c10d4bc-cf70-4668-84c3-251974e01f32'; 
