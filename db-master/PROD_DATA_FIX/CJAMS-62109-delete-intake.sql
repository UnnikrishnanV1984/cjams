/*
Issue Description: CJAMS-62109 Did not case connect for assignment
Category/Module: Intake
Root cause: Incorrect intake I251013359216 created by the user and data fix needed to delete it.
Fix provided: Data fix has been done to delete the intake for all intake related tables
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed to correct the intake.
*/

update cjams.intakedastatus 
set activeflag =0,
    updatedby ='CJAMS-62109', 
    updatedon =now()
where intakenumber ='I251013359216'
and activeflag=1;

update cjams.intakedastaging 
set activeflag =0,
    updatedby ='CJAMS-62109',
    updatedon =now()
where intakenumber ='I251013359216' 
and activeflag=1;

update cjams.intakesnapshot 
set activeflag =0,
    updatedby ='CJAMS-62109',
    updatedon =now()
where intakenumber ='I251013359216' 
and activeflag=1;

update cjams.intakeservicerequest 
set activeflag =0,
    updatedby ='CJAMS-62109',
    updatedon =now()
where intakenumber ='I251013359216' 
and activeflag=1;

update routing 
set activeflag =0,
    updatedby ='CJAMS-62109',
    updatedon =now()
where objectid ='I251013359216' 
and activeflag=1;
