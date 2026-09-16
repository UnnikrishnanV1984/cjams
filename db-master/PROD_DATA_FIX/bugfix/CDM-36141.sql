
/*
   Issue Description: CDM-36141
   Category/ Module  : Intake
   Root cause: user requested to screenout intake.
   Fix Provided: Did data fix to screenout intake and removed service case as requested 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-36141', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011813838' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-36141', updatedon = now()
WHERE intakenumber = 'I231011813838' AND activeflag=1;

Update routing set 
routingstatustypeid = 8,activeflag=0, updatedon= now()
WHERE objectid = 'I231011813838';

update intakeDAStatus set status = 8, updatedby = 'CDM-36141', updatedon = now() 
where intakenumber = 'I231011813838' and activeflag =1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-36141', updatedon = now() 
where intakenumber = 'I231011813838';


update servicecase set activeflag =0, updatedby = 'CDM-36141', updatedon = now() 
where servicecaseid = '475313e3-4de3-41a0-9ffd-2c60ba02f14b';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-36141', updatedon = now() 
where servicecaseid = '475313e3-4de3-41a0-9ffd-2c60ba02f14b';

update servicecaserequest set activeflag = 0, updatedby = 'CDM-36141', updatedon = now() 
where servicecaseid = '475313e3-4de3-41a0-9ffd-2c60ba02f14b';

update caseassignment set activeflag = 0, updatedby = 'CDM-36141', updatedon = now()
where objectid = '475313e3-4de3-41a0-9ffd-2c60ba02f14b'
and activeflag = 1;