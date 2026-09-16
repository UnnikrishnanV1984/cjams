-- CDM-37066 - I&R Closure
/* Issue Description:User request to screen out the case #I211010159588

-- Intake case number: I211010159588

-- Category/ Module: Decision

-- Root cause: User request to screen out the case #I211010159588
-- Fix Provided: Datafix has been provided to update case to screenout
-- Pull request# N/A

*/

select * from intakedastaging WHERE intakenumber = 'I211010159588' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-37066', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010159588' AND activeflag=1;

select fromsecurityusersid,routingstatustypeid,* from routing where objectid='I211010159588' and activeflag =1;

update cjams.routing 
set routingstatustypeid = 8, activeflag = 0,
updatedby = 'CDM-37066', updatedon = now()
where routingid ='bc05c3f5-b1b5-40d8-a962-e075e8385814' and activeflag = 1;