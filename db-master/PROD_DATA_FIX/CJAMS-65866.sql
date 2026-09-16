/*
   Issue Description: CJAMS-65866
   Category/ Module  : intake decision
   Root cause: User accidentally changed the decision to screenin instead of screenout and requested to change the decision to screenout. 
   Fix provided: Datafix to correct the decision to screenout for the intake.
   Regression Impacts: N/A
   Reason why no related code fix: No code fix
   Status of the code fix if already submitted and expected prod fix date:
*/

UPDATE intakesnapshot
SET
updatedby = 'CJAMS-65866', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013914646' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-65866', updatedon = now()
WHERE intakenumber = 'I261013914646' AND activeflag=1;

Update routing 
set routingstatustypeid = 8, supervisordecision ='screenout', 
activeflag = 0, updatedby ='CJAMS-65866', updatedon= now()
WHERE objectid = 'I261013914646';

update intakeDAStatus 
set status = 8, updatedby = 'CJAMS-65866', updatedon = now() 
where intakenumber = 'I261013914646' and activeflag =1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-65866', updatedon = now() 
where intakenumber = 'I261013914646';
