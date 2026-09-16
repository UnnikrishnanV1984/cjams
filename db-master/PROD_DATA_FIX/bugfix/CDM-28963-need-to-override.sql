/*
   Issue Description: CDM-28963
   Category/ Module  : override decision 
   Root cause: user requested to override decision
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE intakedastaging
SET 
updatedby = 'CDM-28963', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I231010501253' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-28963', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{dispositioncode}', 'null'))))
WHERE intakenumber = 'I231010501253' AND activeflag=1;


UPDATE intakedastaging
SET 
updatedby = 'CDM-28963', updatedon = now(), jsondata = jsonb_set(jsondata, '{disposition}', 
			jsonb_set(jsondata->'disposition', '{0}', 
			jsonb_set(jsondata->'disposition'->0, '{supDisposition}', 'null')))
WHERE intakenumber = 'I231010501253' AND activeflag=1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-28963', updatedon = now(), jsondata = jsonb_set(jsondata, '{disposition}', 
			jsonb_set(jsondata->'disposition', '{0}', 
			jsonb_set(jsondata->'disposition'->0, '{dispositioncode}', 'null')))
WHERE intakenumber = 'I231010501253' AND activeflag=1;


update routing
set updatedby = 'CDM-28963', updatedon = now(), routingstatustypeid  = 1
where objectid = 'I231010501253' and activeflag = 1 and routingid = '1c3b6042-5614-46e4-91d3-a9abd091cc93';

update intakedastatus
set updatedby = 'CDM-28963', updatedon = now(), status = 1
where intakenumber = 'I231010501253';

update intakedastaging
set
updatedby = 'CDM-28963', updatedon = now(),
status = 'pending',
ispreintake = FALSE
where intakenumber = 'I231010501253' and activeflag = 1;

update intakesnapshot
set
updatedby = 'CDM-28963', updatedon = now(), activeflag = 0
where intakenumber = 'I231010501253' and activeflag = 1;