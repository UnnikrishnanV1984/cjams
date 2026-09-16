/*
Issue Description:CJAMS-64630 Delete intake
Category/Module: Intake Dashboard
Root cause: Intake I251013509957 is created incorrectly and data fix needed to delete it and remove it from the intake dashboard.
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-64630',
    updatedon = now()
where intakenumber='I251013509957'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-64630',
    updatedon = now()
where intakenumber='I251013509957'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-64630',
    updatedon = now()
where objectid = 'I251013509957'
and activeflag = 1;