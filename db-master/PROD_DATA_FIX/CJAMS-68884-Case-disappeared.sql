/*
Issue Description: CJAMS-68884
Category/Module: Intake did not case connect
Root cause: I261014123036 - remove the approval record so the supervisor just need to approve the intake again for the case creation
Fix provided: Data fix todata fix to revert the approval of the intake: I261014123036 
and put it back to the supervisor for approval.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update routing
set routingstatustypeid  = 1,
supervisordecision = null,
updatedon = now()
where objectid = 'I261014123036' and activeflag = 1;

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CJAMS-68884'
where intakenumber = 'I261014123036' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CJAMS-68884'
where intakenumber = 'I261014123036' and activeflag = 1;

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68884'				
where intakenumber = 'I261014123036' and activeflag = 1;

update intakesnapshot
set jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""')))),
updatedon = now(),
updatedby = 'CJAMS-68884'
where intakenumber = 'I261014123036' and activeflag = 1;

