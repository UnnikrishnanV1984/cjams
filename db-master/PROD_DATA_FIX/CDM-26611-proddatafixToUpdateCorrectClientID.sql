/*
   Issue Description: CDM-26611
   Category/ Module  : Prod data fix to update correct clientid
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 200859121
update tb_client_eligibility set client_id = '4250608', update_user_id = 'CDM-26611', update_ts = now()
where removal_id = '254582';