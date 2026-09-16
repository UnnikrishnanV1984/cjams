/*
   Issue Description: CDM-28277
   Category/ Module  : Prod data fix to update removal information
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

-- 2022-07-24 00:00:00.000
update intakeservreqchildremoval set exitdate = '2022-07-24 00:00:00.000', updatedby = 'CDM-28277', updatedon = now() 
where intakeservreqchildremovalid = '35925988-ec01-4c1a-a344-d12d7022511e';

-- 2022-07-24
update tb_client_eligibility set end_dt  = '2022-07-24', update_user_id = 'CDM-26516', update_ts = now() 
where removal_id = '151202';

-- 2022-07-24
update personprogramarea set enddate = '2022-07-24 00:00:00.000', 
updatedby = 'CDM-28277', updatedon = now()  where personprogramid = '4b282c3d-1808-4efc-b879-487c73993963';