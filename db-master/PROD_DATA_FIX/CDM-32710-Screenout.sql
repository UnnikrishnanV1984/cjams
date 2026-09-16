/*
   Issue Description: CDM-32710
   Category/ Module  : Intake   
   Root cause: User requested to update the intake  as screenout  
  Fix Provided: Did data fix to update the intake screenout 
*/


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-32710', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010708795' AND activeflag=1;


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-32710', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010708795' AND activeflag=1;

update cjams.routing set routingstatustypeid =8, activeflag =0
where routingid ='38dfbddc-cb52-46ef-b875-6a170011658f';

--No record is there 
--select * from intakeservicerequest where intakenumber ='I231010708795';