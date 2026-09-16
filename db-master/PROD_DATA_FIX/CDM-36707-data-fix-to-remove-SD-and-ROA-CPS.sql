-- CDM-36707-data-fix-to-remove-SD-and-ROA-CPS
/*	   
-- Issue  Description: 
    1. Delete Supervisor Decision from Intake# I241012022258
    2. Delete the associated ROA-CPS case# 241021861930
-- Root cause: User wants to delete case which was approved/created in error.
-- Fix provided: Datafix has been promoted to remove Supervisor Decision from Intake and associated ROA-CPS case.

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Backup
select eventcode,updatedon,updatedby,routingstatustypeid from routing where objectid = 'I241012022258';
-- Update
update routing
set routingstatustypeid  = 1,
eventcode = 'INTR',
updatedon = now(),
updatedby = 'CDM-36707'
where objectid = 'I241012022258';

-- Backup
select status,updatedon,updatedby from intakedastatus where intakenumber = 'I241012022258' and activeflag=1;
-- Update
update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-36707'
where intakenumber = 'I241012022258' and activeflag=1;

-- Backup
select status,ispreintake,updatedby,updatedon,jsondata from intakedastaging WHERE intakenumber = 'I241012022258' AND activeflag=1;
-- Update
UPDATE intakedastaging
SET 
status = 'pending',
ispreintake = FALSE,
updatedby = 'CDM-36707', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I241012022258' AND activeflag=1;

-- Backup
select updatedby,updatedon,jsondata from intakesnapshot WHERE intakenumber = 'I241012022258' AND activeflag=1;
-- Update
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-36707', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I241012022258' AND activeflag=1;

-- Backup
select  activeflag,updatedby,updatedon from intakeservicerequest where servicerequestnumber = '241021861930';
-- Update
update intakeservicerequest set activeflag = 0, updatedby = 'CDM-28548',
updatedon = now() where servicerequestnumber = '241021861930';