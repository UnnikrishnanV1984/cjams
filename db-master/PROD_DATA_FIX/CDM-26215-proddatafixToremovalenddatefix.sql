/*
   Issue Description: CDM-26215
   Category/ Module  : Prod data fix to update removal end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 2022-10-27 10:00:00.000
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-26215' where personprogramid  = 'ef6454c5-a026-400d-a888-dd33b784f76f';

-- 2022-10-27 10:00:00.000
update intakeservreqchildremoval set exitdate = null, updatedby ='CDM-26215', updatedon = now()
where intakeservreqchildremovalid = '09d6d229-9b8c-4104-a6d1-4a5830b492c9';

--2022-10-27
update tb_client_eligibility set end_dt = null, update_user_id  ='CDM-26215', update_ts  = now() where removal_id = '251391';