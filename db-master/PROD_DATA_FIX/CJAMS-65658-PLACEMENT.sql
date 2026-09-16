/*
Issue: CJAMS-65658 Placement Exit
Category/Module: Placement Exit
Root cause:  I have made multiple attempts to create a placement in CJAMS for youth Mehki Stewart CJAMS#3517606 (DOB: 3/14/2013), but the system isn't allowing me to submit it for approval. This placement is with Lifeworks Treatment Foster Care Program and the placement date was on 02/13/2026Please help to resolve.See attachment for further explanation.
Fix provided: Data fix.
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a user error and data fix should resolve it. 
*/

UPDATE prov.tb_contract_program 
SET row_lock = null, update_user_id = 'CJAMS-65658', update_ts = now() 
WHERE program_id=50006754  and delete_sw ='N';

