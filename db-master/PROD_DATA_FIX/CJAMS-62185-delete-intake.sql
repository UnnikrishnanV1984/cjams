/*
Issue Description:CJAMS-62185 Referral is Stuck
Category/Module: Intake Dashboard
Root cause: Intake is created incorrectly and data fix needed to delete it and remove it from the intake dashboard.
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-62185',
    updatedon = now()
where intakenumber='I241012849245'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-62185',
    updatedon = now()
where intakenumber='I241012849245'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-62185',
    updatedon = now()
where objectid = 'I241012849245'
and activeflag = 1;