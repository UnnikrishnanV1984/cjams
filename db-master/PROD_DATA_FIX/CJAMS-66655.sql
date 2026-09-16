
/*
Issue: Changed author to the supervisor and won't allow sup to approve referral
Category/Module: Intake
Root cause: Need to change the author name to the intake worker who created the intake.
Fix provided: Data fix provided to update the author name to the intake worker who created the intake.
Data/Code fix ticket#: CJAMS-66655
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error, no code fix needed.
*/

UPDATE intakedastaging 
set  jsondata = (jsonb_set(jsondata, '{General, Author}', '"EmilyRivera"') ::jsonb),
updatedby = 'CJAMS-66655', updatedon = now()
WHERE intakenumber = 'I261013984574' AND activeflag=1;