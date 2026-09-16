/*
Issue Description:CJAMS-64963 Delete intake
Category/Module: Intake Dashboard
Root cause: User is requested to remove the Intake # I251013639490
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/

update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-64963',
    updatedon = now()
where intakenumber='I251013639490'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-64963',
    updatedon = now()
where intakenumber='I251013639490'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-64963',
    updatedon = now()
where objectid = 'I251013639490'
and activeflag = 1;

update intakesnapshot 
set activeflag =0,
    updatedby = 'CJAMS-64963',
    updatedon = now()
where intakenumber = 'I251013639490'
and activeflag = 1;

