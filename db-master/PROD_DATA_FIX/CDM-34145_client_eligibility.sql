/*
   Issue Description: CDM-34145
   Category/ Module : Foster care IVE
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.tb_client_eligibility
SET client_id=4284981, update_user_id='CDM-34145', update_ts=now()
WHERE eligibility_id=10003850 and removal_id=253160;
