/*
Issue Description:CJAMS-69106 
Category/Module: Intake Dashboard
Root cause: User is requested to create a service case as the intake is screenedin but case was not generated
Fix provided: Data fix has been done to link the service case to the intake as it is missing
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This intake is created incorrectly and data fix should be fixing it.
*/

update routing
set routingstatustypeid  = 1,
	supervisordecision = null,
	updatedon = now()
where objectid = 'I261014129170' and activeflag = 1;

update intakedastatus
set status = 1, 
	updatedby = 'CJAMS-69106', 
    updatedon = now()
where intakenumber = 'I261014129170' and activeflag=1;

update intakedastaging
set
  status = 'pending',
  ispreintake = false,
  updatedby = 'CJAMS-69106',
  updatedon = now()
where intakenumber = 'I261014129170' and activeflag = 1;

update intakesnapshot
set activeflag = 0,
	updatedby = 'CJAMS-69106',
	updatedon = now()
where intakenumber = 'I261014129170' and activeflag = 1;
