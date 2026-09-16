/*
  Issue Description:  CDM-40075
   Category/ Module  :  Assignments
   Root cause: User request to do a data fix to update the Supervisor decision as 'Screen out'.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-40075', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012715296' AND activeflag=1;

update routing set supervisordecision = 'screenout'  where routingid = 'ab5ac491-8dcb-48fc-a1bd-d6c5a5233d33' 
and objectid = 'I241012715296';

