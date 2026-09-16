/*
   Issue Description: CDM-41791
   Category/ Module  :Intake
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-41791', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012104685' AND activeflag=1; -- for this table activeflag was already 0


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-41791', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012104685' AND activeflag=1;


Update routing set 
updatedon = now(), 
routingstatustypeid = 8,
supervisordecision ='screenout'
WHERE routingid  ='2a8d8419-953c-44d8-b365-6d8630dd0f76';


update intakedastatus 
set status = 8, updatedby = 'CDM-41791', updatedon = now()
where intakenumber = 'I241012104685' and activeflag = 1;