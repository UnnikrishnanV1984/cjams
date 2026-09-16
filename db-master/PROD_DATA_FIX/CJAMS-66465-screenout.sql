/*
Issue: CJAMS-66465 Incorrect CJAMS number
Category/Module: screen out referral
Root cause: 261030622563  :this referral I261013965366 needs to be screened out.Its a support ticket. User does not have an option to override the intake for request for service intake.
            We also need to disconnect the servicase from intake
Fix provided:  Data fix is done screenout the intake I251013359589 and disconnect the servicecase
Data/Code fix ticket#: CJAMS-66465
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a support ticket and user has no option to override the intake.
*/



UPDATE intakesnapshot
SET
updatedby = 'CJAMS-66465', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013965366' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-66465', updatedon = now()
WHERE intakenumber = 'I261013965366' AND activeflag=1;

--- adding updatedby as moniquewilson name to reflect in the submission history
Update routing set 
routingstatustypeid = 8, activeflag=0, updatedby = '03d9cd8c-6c21-4bff-bf9a-7ebfc5bcdfa0', supervisordecision = 'screenout', updatedon= now()
WHERE objectid = 'I261013965366' and routingid='0a4c6427-333e-4eaa-8cbd-b6fc8b5cf952';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-66465', updatedon = now() 
where intakenumber = 'I261013965366' and activeflag =1;

update intakeservicerequest 
set activeflag = 0, servicecaseid = null, updatedby = 'CJAMS-66465', updatedon = now() 
where intakenumber = 'I261013965366';