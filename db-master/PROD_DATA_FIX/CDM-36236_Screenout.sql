-- CDM-36236 - SCREEN OUT
/* Issue Description:User request to screen out the case #I231011689605

-- Intake case number: I231011689605

-- Category/ Module: Decision

-- Root cause: User request to screen out the case #I231011689605
-- Fix Provided: Datafix has been provided to update case to screenout
-- Pull request# N/A

*/

select * from intakedastaging WHERE intakenumber = 'I231011689605' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-36236', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011689605' AND activeflag=1;

select fromsecurityusersid,routingstatustypeid,* from routing where objectid='I231011689605';

update cjams.routing 
set routingstatustypeid = 8, activeflag = 0,
updatedby = 'CDM-36236', updatedon = now()
where objectid='I231011689605';


-- No Records Found
select * from intakesnapshot where intakenumber = 'I231011689605';
select * from intakeservicerequest where intakenumber = 'I231011689605';