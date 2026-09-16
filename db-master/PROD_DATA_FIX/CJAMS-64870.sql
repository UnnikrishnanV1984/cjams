/*
Issue Description:CJAMS-64870 Delete intake
I261013778300 Intake number.When adding a clearance intake, I completed all screens, then found dob wasincorrect on form. Said person has no hx. Intake needs to be removed.
Category/Module: Intake Dashboard
Root cause: User is requested to remove the Intake I261013778300
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-64870',
    updatedon = now()
where intakenumber='I261013778300'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-64870',
    updatedon = now()
where intakenumber='I261013778300'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-64870',
    updatedon = now()
where objectid = 'I261013778300'
and activeflag = 1;