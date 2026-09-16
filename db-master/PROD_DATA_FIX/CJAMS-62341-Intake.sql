/*
Issue:I251013366330  :Please delete this intake out of the system. 
Root Cause:Intake  in ('I251013366330  ') User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-62341
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastatus 
set activeflag  = 0, updatedon = now(),updatedby  = 'CJAMS-62341'
where  intakenumber in ('I251013366330') and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-62341'
where  intakenumber in ('I251013366330') and activeflag =1;