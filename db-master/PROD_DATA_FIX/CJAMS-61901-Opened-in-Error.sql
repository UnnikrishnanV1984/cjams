/*
Issue:Please delete the intake from the users Assign Transfer dashboard as the intake is not available in global search.
Root Cause:User request to delete the intake from  Assign Transfer dashboard.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-61901
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



update  intaketransfers 
set activeflag=0,updatedby='CJAMS-61901', updatedon= now()
where intaketransferid='24ffb66a-ceea-41d1-baa3-dfc23698b345' and activeflag=1;




