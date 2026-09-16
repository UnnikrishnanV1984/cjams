/*
   Issue Description: CDM-29710
   Category/ Module  : Child Removal Ive
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.tb_client_eligibility
SET client_id=4484080, update_user_id='CDM-29710', update_ts=now()
WHERE eligibility_id=10017181 and removal_id=262934;
