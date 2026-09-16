/*
Issue:I251013367859:Intake needs to be deleted from CJAMS - no identifying information entered
Root Cause:User request to delete intake ,due to user do not acces do that.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-62386
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

--select * from intakeservicerequest where intakenumber ='I251013367859';
update intakeservicerequest
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62386'
where intakenumber = 'I251013367859' and activeflag = 1;
--select * from intakesnapshot where intakenumber ='I251013367859';
update intakesnapshot
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62386'
where intakenumber = 'I251013367859' and activeflag = 1;
--select * from routing where objectid ='I251013367859';
update routing
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62386'
where routingid = 'edd36ab5-52a2-4468-98f0-9960ef8a3fcf' and activeflag = 1;

update intakedastaging
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62386'
where intakenumber = 'I251013367859' and activeflag = 1;


update intakedastatus
set activeflag = 0,updatedon = now(),updatedby  = 'CJAMS-62386'
where intakenumber = 'I251013367859' and activeflag = 1;