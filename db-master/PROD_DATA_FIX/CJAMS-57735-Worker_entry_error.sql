/*
 Issue Description:CJAMS-57735
 Category/ Module: Intake
 Root cause: User requested to delete intake
 Pull request# N/A
 Reason why no related code fix: User Error
*/

update routing set activeflag=0,updatedon=now(),updatedby='CJAMS-57735' where objectid='I251013217929' and activeflag = 1;
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CJAMS-57735' where intakenumber='I251013217929' and activeflag = 1;
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CJAMS-57735' where intakenumber='I251013217929' and activeflag = 1;
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CJAMS-57735' where intakenumber='I251013217929' and activeflag = 1;
update intakeservicerequest set activeflag = 0, updatedby = 'CJAMS-57735', updatedon =now() where intakenumber='I251013217929' and activeflag = 1;