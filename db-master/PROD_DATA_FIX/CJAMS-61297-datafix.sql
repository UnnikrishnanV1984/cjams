/*
Issue Description: CJAMS-61297
Category/Module: Intake Removal
Root cause: User requested to remove the # I251013337289 as requested. I251013337289 is incomplete and has not been submitted for supervisor approval.
Fix provided: Data fix has been done to to remove the # I251013337289 as requested. I251013337289 is incomplete and has not been submitted for supervisor approval.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update intakedastaging
set activeflag=0, updatedby='CJAMS-61297', updatedon=now()
where intakenumber='I251013337289' and activeflag=1;

update intakedastatus
set activeflag=0, updatedby='CJAMS-61297', updatedon=now()
where intakenumber='I251013337289' and activeflag=1;