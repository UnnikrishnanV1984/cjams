/*
   Issue Description: CDM-41640
   Category/ Module  :Intake
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-41640', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013139501' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-41640', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013139501' AND activeflag=1;

Update routing set 
updatedon = now(), 
routingstatustypeid = 8,
supervisordecision ='screenout'
WHERE routingid ='853eecf0-727a-448f-b031-e452f87b5acb';

update intakedastatus 
set status = 8, updatedby = 'CDM-41640', updatedon = now()
where intakenumber = 'I241013139501' and activeflag = 1;


