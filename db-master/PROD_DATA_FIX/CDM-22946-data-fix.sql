/*
-- CDM-22946-- 

-- Issue Description: 
 Unable to update the status

-- Customer Email ID: theresa.kleppinger@maryland.gov

-- Root cause: Data fix to update the status
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Review         
UPDATE intakedastaging
SET
updatedby = 'CDM-22946', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{DAStatus}', '"Approved"'))))
WHERE intakenumber = 'I221010274616' AND activeflag=1;