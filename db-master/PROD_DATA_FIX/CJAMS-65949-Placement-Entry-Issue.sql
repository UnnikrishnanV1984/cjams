/*
   Issue Description: Cjams-65949
   Category/ Module  : Placement Entry Issue
   Root cause: Not able to proceed with placement entry. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_provider
set  row_lock = null, update_user_id = 'CJAMS-65949', update_ts = now() 
WHERE provider_id =6075891  and delete_sw ='N';

