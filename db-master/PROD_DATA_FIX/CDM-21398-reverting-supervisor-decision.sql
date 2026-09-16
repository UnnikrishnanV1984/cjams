/*
-- CDM-21398 - 

-- Issue Description: 
 Unable to revert the supervisor decision
  
-- Customer Email ID:jameshial.dixon@maryland.gov

-- Root cause: Data fix to revert the supervisor decision
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-21398', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010252380' AND activeflag=1;

--routingstatustypeid = 2
update routing set routingstatustypeid = 1,updatedby = 'CDM-21398', updatedon = now() where objectid = 'I221010252380' and activeflag = 1;

--status = 2
update intakedastatus set status = null, updatedby = 'CDM-21398' , updatedon = now() where intakenumber = 'I221010252380' and activeflag = 1;