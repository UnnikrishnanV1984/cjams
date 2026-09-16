/*
Issue Description:CJAMS-65220 Need to be remove from dashboard cjams no: 261013886949
Category/Module: Intake Dashboard
Root cause: Intake I261013886949 is created incorrectly and data fix needed to delete it and remove it from the intake dashboard.
Fix provided: Data fix has been done to delete the intake from intake related tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should remove it.
*/


update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-65220',
    updatedon = now()
where intakenumber= 'I261013886949'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-65220',
    updatedon = now()
where intakenumber= 'I261013886949'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-65220',
    updatedon = now()
where objectid = 'I261013886949'
and activeflag = 1;