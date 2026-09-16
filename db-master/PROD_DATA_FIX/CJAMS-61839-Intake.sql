
/*
Issue:I251013349229:Please delete this intake out of the system. 
Root Cause:Intake   'I251013349229' User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-61839
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastatus 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61839'
where intakenumber   = 'I251013349229' and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61839'
where intakenumber   = 'I251013349229'  and activeflag =1;