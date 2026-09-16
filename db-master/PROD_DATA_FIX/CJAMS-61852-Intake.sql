/*
Issue:I251013211377 :Please delete this intake out of the system. 
Root Cause:Intake  in ('I251013211377 ') User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-61852
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastatus 
set activeflag  = 0, updatedon = now(),updatedby  = 'CJAMS-61852'
where  intakenumber in ('I251013211377') and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61852'
where  intakenumber in ('I251013211377') and activeflag =1;

update routing  
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61852'
where  routingid  in ('dcc4d4e3-b065-416b-b574-891bfc4604aa') and activeflag =1;