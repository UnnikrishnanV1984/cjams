/*
-- CDM-32985' 
-- Issue Description: Unable to revert the supervisor decision
-- Root cause: Data fix to revert the supervisor decision
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE intakedastaging 
SET 
updatedby = 'CDM-32985', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231010707060' AND activeflag=1;

update routing set activeflag = 1,updatedby = 'CDM-32985', updatedon = now() 
where objectid = 'I231010707060' 
and routingid = '26c7b726-e5e9-4e47-ad8f-bc887a49a093';
