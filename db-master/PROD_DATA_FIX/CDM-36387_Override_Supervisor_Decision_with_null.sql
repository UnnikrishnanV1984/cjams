-- CDM-36387 - Supervisor Decision Override after SCREEN IN
/* Issue Description:User can not screenout  the case #I241011895441

-- Intake case number: I241011895441

-- Category/ Module: Decision

-- Root cause: User can not screenout the case #I241011895441
-- Fix Provided: Datafix has been provided to update case to nullify the supervisor decision
-- Pull request# N/A

*/

select * from intakedastaging WHERE intakenumber = 'I241011895441' AND activeflag=1;

UPDATE intakedastaging
SET updatedby = 'CDM-36387', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I241011895441' AND activeflag=1;