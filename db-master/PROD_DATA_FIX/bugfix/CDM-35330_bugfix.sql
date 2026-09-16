/*
   Issue Description: CDM-35330
   Category/ Module  : Screen Referral Out
   Root cause: To change screenIn to ScreenOut in supervisor decision To change status from Review to closed
   Fix Provided: Changed to Screen out and status to closed
*/
--To change screenIn to ScreenOut in supervisor decision.
UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-35330', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011393670' AND activeflag=1;


--To change status from Review to closed
update cjams.routing 
set routingstatustypeid = 8
where routingid ='afb79a3a-13e5-40a6-bbfa-4151fd8f3acf' and objectid = 'I231011393670' and activeflag = 1;