/*
   Issue Description: CJAMS-66526
   Category/ Module  : Intake
   Root cause: user requested to screenout intake.
   Fix Provided: Did data fix to screenout intake and removed service case as requested 
*/

UPDATE 	intakesnapshot 
SET 	updatedby = 'CJAMS-66526', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261013977136' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-66526', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013977136' AND activeflag=1;


update cjams.routing 
set routingstatustypeid =8, supervisordecision='ScreenOUT', updatedon = '2026-03-20T12:00:00' 
where routingid='3e1456d9-e0fc-4afa-98f5-50d44c68d96d' and activeflag = 1;