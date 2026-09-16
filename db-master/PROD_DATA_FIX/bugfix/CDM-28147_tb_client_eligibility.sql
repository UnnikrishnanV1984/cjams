/*
   Issue Description: CDM-28147
   Category/ Module  :  Child Removal eligibility
   Root cause: Approval records :  
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

UPDATE cjams.tb_client_eligibility
SET client_id=200885096, update_user_id='CDM-28147', case_id=221030015070, update_ts=now()
WHERE eligibility_id=10004639 and removal_id=253751;
