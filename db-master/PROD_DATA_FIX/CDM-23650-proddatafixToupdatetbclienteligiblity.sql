/*
   Issue Description: CDM-23650
   Category/ Module  : Prod data fix to update correct client id details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

  
  --4414725
  update tb_client_eligibility set client_id = '200645789', update_user_id = 'CDM-23650',
  update_ts =  now()
  where removal_id = '253137';