-- CDM-41807 - Screen out the intake and remove the service case out of it.
/*
-- Issue Description: 
   User request to delete the case 241030399490 and screenout the intake# I241013132832.
-- Case ID: 241030399490
-- Intake#: I241013132832
-- Category/ Module: Case Deletion 
-- Root cause: User request to delete the case 241030399490 and screenout the intake# I241013132832.
-- Fix Provided: Datafix has been provided to soft delete the case and screenout the intake. 
-- Regression Impacts: N/A
-- Is Code fix Required?: (Yes/No) No
-- Code fix ticket#: (If Yes) N/A
-- Reason why no related code fix: This issue is not replicable in stage-3 while trying to screenout the intake.
*/
UPDATE intakesnapshot
SET
updatedby = 'CDM-41807', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013132832' AND activeflag=1;

update servicecase set activeflag = 0, updatedby = 'CDM-41807', updatedon = now() 
where servicecaseid = '3fb745b1-76e2-4c66-9d71-e13f41181eac' and servicecasenumber = '241030399490' and activeflag = 1;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-41807', updatedon = now() 
where servicecaseid = '3fb745b1-76e2-4c66-9d71-e13f41181eac' and activeflag = 1;

update caseassignment set activeflag = 0, updatedby = 'CDM-41807', updatedon = now() 
where objectid = '3fb745b1-76e2-4c66-9d71-e13f41181eac' and activeflag = 1;

update routing set activeflag = 0, updatedby = 'CDM-41807', updatedon = now()
where objectid = '3fb745b1-76e2-4c66-9d71-e13f41181eac' and activeflag = 1;

update routing set activeflag = 0, routingstatustypeid = 8, supervisordecision ='screenout'
where objectid = 'I241013132832' and activeflag = 1;