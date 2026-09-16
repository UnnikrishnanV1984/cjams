/*
Issue:I202100646733:Please delete this intake out of the system. 
Root Cause:Intake  in ('I202100646733') User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-62182
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastatus 
set activeflag  = 0, updatedon = now(),updatedby  = 'CJAMS-62182'
where  intakenumber in ('I202100646733') and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-62182'
where  intakenumber in ('I202100646733') and activeflag =1;

update routing  
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-62182'
where  routingid  in ('c8659d76-84cf-431f-ac33-5be9a6ad9d47') and activeflag =1;
