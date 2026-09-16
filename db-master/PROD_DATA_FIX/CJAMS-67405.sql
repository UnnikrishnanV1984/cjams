/*
Issue: CJAMS-67405 Intake
Category/Module: screen out referral
Root cause: User wants to screenin the case and wants to create a case but no case is created due to a glitch so user has created a new one and user wants to screenout this intake 
Fix provided:  Data fix is done screenout the intake  I261014015070
Data/Code fix ticket#: CJAMS-67405
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a support ticket and user has no option to override the intake.
*/



UPDATE intakesnapshot
SET
updatedby = 'CJAMS-67405', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014015070' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-67405', updatedon = now()
WHERE intakenumber = 'I261014015070' AND activeflag=1;

--- We are not updating udatedby since submittedto/Approvedby name we are getting from uodating by column
Update routing set 
routingstatustypeid = 8, activeflag=0, supervisordecision = 'screenout', updatedon= now()
WHERE objectid = 'I261014015070' and routingid='45c948dc-752b-4c62-8a6c-25df0053de96';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-67405', updatedon = now() 
where intakenumber = 'I261014015070' and activeflag =1;