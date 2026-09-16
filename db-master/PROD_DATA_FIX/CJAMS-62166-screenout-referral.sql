/*
Issue: CJAMS-62166 screen out referral
Category/Module: screen out referral
Root cause: 251013359589:this referral I251013359589 needs to be screened out.Its a support ticket. User does not have an option to override the intake for request for service intake.
            We also need to disconnect the servicase from intake
Fix provided:  Data fix is done screenout the intake I251013359589 and disconnect the servicecase/
Data/Code fix ticket#: CJAMS-62166
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a support ticket and user has no option to override the intake.
*/


UPDATE intakesnapshot
SET
updatedby = 'CJAMS-62166', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013359589' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-62166', updatedon = now()
WHERE intakenumber = 'I251013359589' AND activeflag=1;

--- adding updatedby as supervisor name to reflect in the submission history
Update routing set 
routingstatustypeid = 8, activeflag=0, updatedby = '3f97686f-6759-4552-b31d-381204563d66', supervisordecision = 'screenout', updatedon= now()
WHERE objectid = 'I251013359589' and routingid='6893306c-8aab-4b5d-afea-207b85197267';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-62166', updatedon = now() 
where intakenumber = 'I251013359589' and activeflag =1;

update intakeservicerequest 
set activeflag = 0, servicecaseid = null, updatedby = 'CJAMS-62166', updatedon = now() 
where intakenumber = 'I251013359589';