/*
Issue: CJAMS-64252 Case unable to be located
Category/Module: Intake / Submissin History
Root cause: User request to revert the approve intake :I251013630422:The service case was screened in however is unable to be located to be assigned. 
Fix provided: Data fix has been done to revert the approved intake bring it back to pending status.
Data/Code fix ticket#: CJAMS-64252
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and they have requested for data fix.
*/


update routing
set routingstatustypeid  = 1,
supervisordecision = null,
updatedon = now()
where objectid = 'I251013630422';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CJAMS-64252'
where intakenumber = 'I251013630422' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CJAMS-64252'
where intakenumber = 'I251013630422' and activeflag = 1;

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-64252'				
where intakenumber = 'I251013630422';

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-64252'
where intakenumber= 'I251013630422'
and activeflag = 1;
