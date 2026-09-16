/*
Issue:I251013333576:Please delete this intake out of the system. The intake has incorrect information in the narrative section. I will be correcting and making a whole new intake. Please delete this intake right away. The information is not correct. The user made errors on notes. 
Root Cause:Intake   'I251013333576 ' User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-61177
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastatus 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61177'
where intakenumber   = 'I251013333576' and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61177'
where intakenumber   = 'I251013333576'  and activeflag =1;

update intakeservicerequest 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61177'
where intakenumber   = 'I251013333576'  and activeflag =1;


update intakesnapshot 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-61177'
where intakenumber   = 'I251013333576'  and activeflag =1;