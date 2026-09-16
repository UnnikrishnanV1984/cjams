-- CDM-41808 - Screen out the intake and remove the service case out of it
/*
-- Issue Description: 
   User request to delete the case 241030400993 and screenout the intake# I241013138477.
-- Case ID: 241030400993
-- Intake#: I241013138477
-- Category/ Module: Case Deletion 
-- Root cause: User request to delete the case 241030400993 and screenout the intake# I241013138477.
-- Fix Provided: Datafix has been provided to soft delete the case and screenout the intake. 
-- Regression Impacts: N/A
-- Is Code fix Required?: (Yes/No) No
-- Code fix ticket#: (If Yes) N/A
-- Reason why no related code fix: This issue is not replicable in stage-3 while trying to screenout the intake.
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-41808', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013138477' AND activeflag=1;

update servicecase set activeflag = 0, updatedby = 'CDM-41808', updatedon = now() 
where servicecaseid = '9541deba-1790-4453-8cab-b0454dd2fdc4' and activeflag = 1;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-41808', updatedon = now() 
where servicecaseid = '9541deba-1790-4453-8cab-b0454dd2fdc4' and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CDM-41808', updatedon = now() 
where objectid = '9541deba-1790-4453-8cab-b0454dd2fdc4' and activeflag = 1;

update routing set activeflag = 0, routingstatustypeid = 8, supervisordecision ='screenout'
where objectid = 'I241013138477' and activeflag = 1;
