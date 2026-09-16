/*
   Issue Description: CDM-31456
   Category/ Module  : Prod data fix to remover person program area
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE intakedastaging
SET
updatedby = 'CDM-31554', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '"Review"'))))
WHERE intakenumber in ('I231010612505'
, 'I231010612405', 'I231010612535') AND activeflag=1;
