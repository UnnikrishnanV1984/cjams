/*
   Issue Description: CDM-26343
   Category/ Module  : Prod data fix to update removal information
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2021-10-23 00:00:00.000
update intakeservreqchildremoval set removaldate = '2021-10-22 00:00:00.000', updatedby = 'CDM-26343', updatedon = now() 
where intakeservreqchildremovalid = 'b69e0410-b63c-4d50-91c6-67dd66d15d46';

-- 2021-10-23
update tb_client_eligibility set start_dt  = '2021-10-22', update_user_id = 'CDM-26516', update_ts = now() 
where removal_id = '252965';

-- 2021-10-26
update personprogramarea set startdate = '2021-10-22 00:00:00.000', 
updatedby = 'CDM-26343', updatedon = now()  where personprogramid = '513c0f7c-243f-4548-8906-9fd044f80ee7';
