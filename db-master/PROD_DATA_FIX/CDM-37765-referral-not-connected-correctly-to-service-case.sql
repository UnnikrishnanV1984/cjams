/*
   Issue Description: CDM-37765
   Root cause:  Intake I241012082586 screened in and approved but no service case created or connected. Need to move back to Supervisor Approval so supervisor can approve and create or connect to service case or the intake worker can resubmit for approval again.
   Fix:  Datafix has been promoted to remove Supervisor Decision from Intake.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Backup
select eventcode,updatedon,updatedby,routingstatustypeid from routing where objectid = 'I241012082586';
--UPDATE cjams.routing
--SET updatedon='2024-03-12 11:54:06.568', updatedby='780b2012-4a49-4e6d-9471-d1b2e4026c75', routingstatustypeid=2
--where objectid = 'I241012082586';

-- Update
update routing
set routingstatustypeid  = 1,
updatedon = now(),
updatedby = 'CDM-37765'
where objectid = 'I241012082586';

-- Backup
select status,updatedon,updatedby from intakedastatus where intakenumber = 'I241012082586' and activeflag=1;
--UPDATE cjams.intakedastatus
--SET status=2, updatedon='2024-03-12 11:54:06.568', updatedby='780b2012-4a49-4e6d-9471-d1b2e4026c75'
--WHERE intakenumber = 'I241012082586' and activeflag=1;

-- Update
update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-37765'
where intakenumber = 'I241012082586' and activeflag=1;

-- Backup
select status,ispreintake,updatedby,updatedon,jsondata from intakedastaging WHERE intakenumber = 'I241012082586' AND activeflag=1;
--UPDATE cjams.intakedastaging
--SET status='Complete', ispreintake=true, updatedby='780b2012-4a49-4e6d-9471-d1b2e4026c75', updatedon='2024-03-12 11:54:06.568', jsondata= jsonb_set(jsondata, '{DAType}', 
			-- jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			-- jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			-- jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'Scrnin'))))
--WHERE intakenumber = 'I241012082586' AND activeflag=1;

-- Update
UPDATE intakedastaging
SET 
status = 'pending',
ispreintake = FALSE,
updatedby = 'CDM-37765', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
WHERE intakenumber = 'I241012082586' AND activeflag=1;

-- Backup
select updatedby,updatedon,jsondata from intakesnapshot WHERE intakenumber = 'I241012082586' AND activeflag=1;
-- UPDATE cjams.intakesnapshot
-- SET updatedby='780b2012-4a49-4e6d-9471-d1b2e4026c75', updatedon='2024-03-12 11:54:06.568', jsondata=jsonb_set(jsondata, '{DAType}', 
			-- jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			-- jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			-- jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'Scrnin'))))
-- WHERE intakenumber = 'I241012082586' AND activeflag=1;

-- Update
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-37765', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I241012082586' AND activeflag=1;