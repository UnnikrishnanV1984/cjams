/*
   Issue Description: CDM-22766
   Category/ Module  : Prod data fix to remove draft removal
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--200022507
update tb_client_eligibility set client_id = '200399341', update_user_id = 'CDM-17064', update_ts = now() 
where removal_id  = '251520';