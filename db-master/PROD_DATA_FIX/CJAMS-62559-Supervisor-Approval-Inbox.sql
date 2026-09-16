/*
Issue: 251023101440:This case has been in my inbox for a few months. The actual case has been closed out. How do I clear this case from my inbox?
Root Cause:The case was already closed, but the related review task stayed visible in the supervisor’s approval inbox. This happened because the system did not automatically remove the old review record after the case was completed. The inbox item was cleared by manually deactivating that record.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and  routing table..
Data/Code fix ticket#:CJAMS-62559
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update routing
set activeflag =0,updatedby ='CJAMS-62559',updatedon =now()
where routingid ='dcb977a6-039f-487b-a142-32e43fb0ce5e' and activeflag=1;