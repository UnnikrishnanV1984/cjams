/*
Issue: CJAMS-64015 Remove referral from dashboard
Category/Module: intake
Root cause: Intake  I251013397263 is still in draft on  Melissa Charnocks (melissa.charnock@maryland.gov) workload . It is no longer needed and data fix needed to resolve it.
Fix provided: Data fix has been done to delete the intake I251013397263 from all intake related tables.
Data/Code fix ticket#: CJAMS-64015
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested to remove draft intake and data fix should resolve it.
*/



update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64015'
where intakenumber = 'I251013397263'and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64015'
where intakenumber = 'I251013397263' and activeflag=1;