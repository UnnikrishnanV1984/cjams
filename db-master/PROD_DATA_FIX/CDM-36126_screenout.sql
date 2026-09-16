-- CDM-36126 - SCREEN OUT
/* Issue Description:User request to screen out the case #I231011779088

-- Intake case number: I231011779088

-- Category/ Module: Decision

-- Root cause: User request to screen out the case #I231011779088
-- Fix Provided: Datafix has been provided to update case to screenout
-- Pull request# N/A

*/

select * from intakedastaging WHERE intakenumber = 'I231011779088' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-36126', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011779088' AND activeflag=1;

select fromsecurityusersid,routingstatustypeid,* from routing where objectid='I231011779088';

update cjams.routing 
set routingstatustypeid = 1, activeflag = 0,
updatedby = 'CDM-36126', updatedon = now()
where routingid ='7312221d-c984-4566-b824-c8e958eb0e32';