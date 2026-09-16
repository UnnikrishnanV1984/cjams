/*
   Issue Description: CJAMS-66881
   Category/ Module  : Screen Referral Out
   Root cause: To change screenIn to ScreenOut in supervisor decision To change status from Review to closed
   Fix Provided: Changed to Screen out and status to closed
*/



UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-66881', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013995892' AND activeflag=1;

UPDATE intakesnapshot 
SET 
updatedby = 'CJAMS-66881', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013995892' AND activeflag=1;

update cjams.routing 
set routingstatustypeid = 8, activeflag = 0, updatedby = 'CJAMS-66881', updatedon = now()
where routingid ='58aff2a4-6afe-4a7e-af6a-6c5cf373a368';

update intakedastatus
set status = 8, updatedby = 'CJAMS-66881', updatedon = now()
where intakenumber = 'I261013995892'
and activeflag = 1;
