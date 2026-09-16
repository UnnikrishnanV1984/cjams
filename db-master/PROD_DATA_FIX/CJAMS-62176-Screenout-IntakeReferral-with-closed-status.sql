-- CJAMS-62176: Screening out the intake referral with closed status
/*
-- Issue Description: 
   User request to screenout the intake# I251013342526 with closed status.
-- Intake#: I251013342526
-- Category/ Module: Case Deletion 
-- Root cause: User request to screenout the intake# I251013342526 with closed status.
-- Fix Provided: Datafix has been provided to screenout the intake with closed status. 
-- Regression Impacts: N/A
-- Is Code fix Required?: (Yes/No) No
-- Code fix ticket#: (If Yes) N/A
-- Reason why no related code fix: This issue is not replicable in stage-3 while trying to screenout the intake with closed status.
*/

UPDATE intakesnapshot 
SET updatedby = 'CJAMS-62176', updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013342526' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed', updatedby = 'CJAMS-62176', updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}',
        jsonb_set(jsondata->'DAType', '{DATypeDetail}',
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I251013342526' AND activeflag=1;

update routing set supervisordecision = 'screenout', routingstatustypeid = 8, 
    updatedon = '2025-08-19 20:00:00.178', updatedby = '0ae86a6f-5365-4bb2-b079-f85eb391a2ae'
where routingid = 'd8dba76e-852d-4ae1-8f1b-45b29b9b32c3'  and objectid ='I251013342526';