/*
   Issue Description: CDM-43998
   Category/ Module  : Missing intake number
   Data fix: 
*/


UPDATE intakesnapshot
SET
updatedby = 'CDM-43998', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013211835' AND activeflag=1;


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-43998', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013211835' AND activeflag=1;


update routing 
set activeflag = 0,routingstatustypeid = 8, supervisordecision = 'screenout',updatedby ='CDM-43998', updatedon = now()
where objectid ='I251013211835' and activeflag = 1;



update caseassignment
set activeflag = 0, updatedby = 'CDM-43998', updatedon = now() 
where objectid = '1582fecc-645e-47e0-8b79-b617af2660ff' and activeflag = 1;


