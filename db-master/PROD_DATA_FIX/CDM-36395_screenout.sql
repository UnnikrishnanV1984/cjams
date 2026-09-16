-- CDM-36395 -Sdm SCREEN OUT
/* Issue Description:User can not screenout  the case #I241011894117

-- Intake case number: I241011894117

-- Category/ Module: Decision

-- Root cause: User can not screenout the case #I241011894117
-- Fix Provided: Datafix has been provided to update case to nullify the supervisor decision
-- Pull request# N/A

*/

select * from intakedastaging WHERE intakenumber = 'I241011894117' AND activeflag=1;

UPDATE intakedastaging
SET updatedby = 'CDM-36395', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I241011894117' AND activeflag=1;
