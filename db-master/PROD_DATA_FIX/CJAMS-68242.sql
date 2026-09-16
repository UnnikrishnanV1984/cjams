/*
Issue: CJAMS-68242 Intake
Category/Module: screen out referral
Root cause: User wants to screenout this intake 
Fix provided:  Data fix is done screenout the intake  I261014095474
Data/Code fix ticket#: CJAMS-68242
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a support ticket and user has no option to override the intake.
*/



UPDATE intakesnapshot
SET
updatedby = 'CJAMS-68242', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014095474' AND activeflag=1;


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-68242', updatedon = now()
WHERE intakenumber = 'I261014095474' AND activeflag=1;

--- We are not updating udatedby since submittedto/Approvedby name we are getting from uodating by column
Update routing set 
routingstatustypeid = 8, activeflag=0, supervisordecision = 'screenout', updatedon= now()
WHERE objectid = 'I261014095474' and routingid='80963f4d-bb7c-4da6-a282-dffcda1c4554';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-68242', updatedon = now() 
where intakenumber = 'I261014095474' and activeflag =1;