/*
   Issue Description: CDM-29084
   Category/ Module  : Client Eligibility record missing
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/

UPDATE cjams.tb_client_eligibility
SET client_id=3217944, update_user_id='CDM-29084', update_ts=now()
WHERE eligibility_id=10006052 and removal_id=254819;
