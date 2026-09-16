/*
   Issue Description: CDM-21580
   Category/ Module  : Intake
   Root cause: user wants to remove the supervisor decision
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-21580', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010253064' AND activeflag=1;

update intakedastatus set status = null, updatedby = 'CDM-21580' , updatedon = now() where intakenumber = 'I221010253064' and activeflag = 1;

update routing set routingstatustypeid = 1,updatedby = 'CDM-21580', updatedon = now() where objectid = 'I221010253064' and activeflag = 1;

