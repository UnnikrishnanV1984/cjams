/*
Issue Description:CJAMS-61989 Delete intake
Category/Module: Intake Dashboard
Root cause: I241013129272:This was a family preservation case that was entered as a duplicate
			User is requested to remove the Intake # I241013129272
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-61989',
    updatedon = now()
where intakenumber='I241013129272'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-61989',
    updatedon = now()
where intakenumber='I241013129272'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-61989',
    updatedon = now()
where objectid = 'I241013129272'
and activeflag = 1;


