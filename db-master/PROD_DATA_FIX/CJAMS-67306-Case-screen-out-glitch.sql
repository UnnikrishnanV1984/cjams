/*

-- CJAMS-67306 - SCREEN OUT
 Issue Description:User request to screen out the case #I261014009024 

-- Intake case number: I261014009024 

-- Category/ Module: Decision

-- Root cause: User request to screen out the case #I261014009024 
-- Fix Provided: Datafix has been provided to update case to screenout
-- Pull request# N/A

*/


UPDATE intakesnapshot
SET
updatedby = 'CJAMS-67306', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014009024' AND activeflag=1;

UPDATE intakedastaging
SET ispreintake=false,status = 'Closed',
updatedby = 'CJAMS-67306', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014009024' AND activeflag=1;


update routing
set updatedby = 'CJAMS-67306',routingstatustypeid=8, updatedon = now(), supervisordecision='screenout',approveddate='2026-04-22 18:53:51.837'
where routingid='447534c8-29ee-4edb-9103-d0ffc6ee4f34';



update intakeservicerequest 
set activeflag =0, updatedby = 'CJAMS-67306', updatedon = now() 
where servicerequestnumber ='261023740264' and activeflag =1;