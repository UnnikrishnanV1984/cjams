/*
   Issue Description: CDM-31159
   Category/ Module  : Prod data fix to update removal information
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
update intakeservreqchildremoval set exitdate = '2023-03-01 00:00:00.000', updatedby = 'CDM-31159', updatedon = now() 
where intakeservreqchildremovalid = '055175e2-31fa-4088-aa20-c73da9d8d7fa';

-- 2022-07-24
update tb_client_eligibility set end_dt  = '2023-03-01', update_user_id = 'CDM-31159', update_ts = now() 
where removal_id = '257481';

-- 2022-07-24
update personprogramarea set enddate = '2023-03-01 00:00:00.000', 
updatedby = 'CDM-31159', updatedon = now()  where personprogramid = '5e14a032-2603-4778-a7ce-9766ea79e39b';