/*
   Issue Description: CDM-42620
   Category/ Module  : Child Welfare
   Root cause: Delete this service case and Override screen Out the Intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-42626', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013170670' AND activeflag=1;


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-42626', updatedon = now(),
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013170670' AND activeflag=1;

update routing
set updatedby = 'CDM-42626', updatedon = now(), supervisordecision='ScreenOUT'
where routingid='b760433a-6b59-468c-bd5f-cd0dc7ec9dde';




