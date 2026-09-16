/*
   Issue Description: CDM-25640
   Category/ Module  : Prod data fix to update correct client ID
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 4118152
update tb_client_eligibility set client_id = '200654179', update_ts = now() , update_user_id = 'CDM-25640' where 
removal_id = '254145';