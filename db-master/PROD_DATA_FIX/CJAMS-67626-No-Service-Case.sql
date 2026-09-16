/*	   
-- Issue  Description: 
  delete supervisor decision
   Please carry out data fix to keep the Intake# I261014019149 in Review status 
-- Root cause: User wants to delete case which was approved/created in error.
-- Fix provided: Datafix has been promoted.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing
set routingstatustypeid  = 1,supervisordecision=null,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CJAMS-67626'
where objectid = 'I261014019149' and activeflag=1;

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CJAMS-67626'
where intakenumber = 'I261014019149' and activeflag=1;


UPDATE intakedastaging
SET 
status = 'pending',
ispreintake = FALSE,
updatedby = 'CJAMS-67626', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I261014019149' AND activeflag=1;


