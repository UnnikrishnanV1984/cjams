/*
Issue:I251013349229:Please delete this intake out of the system. 
Root Cause:Intake  in ('CW9881101','CW10201535') User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-61950
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastatus 
set  updatedon = now(),updatedby  = 'CJAMS-61950',status='8'
where  intakenumber in ('CW9881101','CW10201535') and activeflag =1;

update intakedastaging 
set   updatedon = now(),updatedby  = 'CJAMS-61950',status='Closed'
where  intakenumber in ('CW9881101','CW10201535') and activeflag =1;
