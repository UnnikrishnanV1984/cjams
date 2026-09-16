/*
   Issue Description: CJAMS-59027
   Category/ Module  : User was able to screen out the intake but the status is displaying as Accepted in person search,
   also the intake is displaying twice in the person search screen.
   Root cause: Data issue, there was one feild in db wasn't updated after the case was closed.
   Pull request# 
   Reason why no related code fix: because it wasn't replicable in the current system.
   Status of the code fix if already submitted and expected prod fix date: 
*/
update intakeservicerequest
set activeflag =0,
	updatedby = 'CJAMS-59027',
	updatedon = now()
where intakeserviceid = 'b3772996-a4ff-4ff6-b162-23aa3177e674'
and activeflag =1;

update intakeservicerequest
set actiontype =null,
	intakeserreqstatustypeid  = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
	updatedby = 'CJAMS-59027',
	updatedon = now()
where intakeserviceid = '08bb2aa6-27f1-4e81-b7db-5a96a080dce7';

