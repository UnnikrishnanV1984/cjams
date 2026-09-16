-- CDM-30905 -Should Not Have Been Accepted. 
/*
-- Issue Description: I231010580387- GLITCH GENERATED REFERRAL ON A SCREEN OUT.
    Customer Email ID:linda.coy@maryland.gov
  
-- Resolution: Updated the jsondata to screen out in the intakedastaging table for the intakenumber = 'I231010580387'

-- Category/ Module: Intake Decision
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-30905', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010580387' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-30905', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010580387' AND activeflag=1;
