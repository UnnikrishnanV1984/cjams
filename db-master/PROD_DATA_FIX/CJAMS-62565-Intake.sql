/*
Issue:I251013262533:Intake needs to be deleted from CJAMS - no identifying information entered
Root Cause:Due to a data entry or system handling error at the time (2015), the intake was saved with status Accepted but no associated cps/case was created.Because it was never screened out either, the record remained active in the database without any valid linkage.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-62565
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--no records
--select * from intakeservicerequest where intakenumber ='I251013262533';
--select * from intakesnapshot where intakenumber ='I251013262533';
--select * from routing where objectid ='I251013262533';

update intakedastaging
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62565'
where intakenumber = 'I251013262533' and activeflag = 1;


update intakedastatus
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62565'
where intakenumber = 'I251013262533' and activeflag = 1;