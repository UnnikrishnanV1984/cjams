/*
Issue:This showed up in my pending review screen yesterday. It's from 2015.The respective case CW9593778 is available under the user pending dashboard.
Root Cause:Due to a data entry or system handling error at the time (2015), the intake was saved with status Accepted but no associated cps/case was created.Because it was never screened out either, the record remained active in the database without any valid linkage.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-62340
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakedastaging
set status = 'Closed',updatedon = now(),updatedby  = 'CJAMS-62340'
where id = 13108250 and activeflag = 1;
