/*
Issue:I211010180408:This intake referral was generated in error. There is no identifying information attached to it. Please delete. Intake #I211010180408 
Root Cause:Intake   'I211010180408 ' User request to delete intake.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-60518
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/




update intakedastatus 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-60518'
where intakenumber   = 'I211010180408' and activeflag =1;

update intakedastaging 
set activeflag  = 0,  updatedon = now(),updatedby  = 'CJAMS-60518'
where intakenumber   = 'I211010180408'  and activeflag =1;