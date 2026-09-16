-- CDM-37719 - Intake approved and CJAMS timed out before opening a service case
/* Issue Description: The Supervisor approval for the intake (I241012079563) should be reverted. So that the intake appears on supervisor approval dashboard and supervisor can approve it and assign to the caseworker.

-- case number: I241012079563
-- Category/ Module: Case Timeline 

-- Root cause: The Supervisor approval for the intake (I241012079563) should be reverted. So that the intake appears on supervisor approval dashboard and supervisor can approve it and assign to the caseworker.
-- Fix Provided: Datafix has been provided to change the supervisors decision for case #I241012079563 
-- Pull request# N/A

*/

select * from routing where objectid='I241012079563' order by insertedon desc; 

UPDATE cjams.routing
SET activeflag = 1,
updatedby = 'CDM-37719',
updatedon = now()
WHERE objectid='I241012079563' and routingstatustypeid = 1;

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('7132c4f5-d8aa-4ca7-ad5e-cf6654ac6035'::uuid, 'INTR', '250e7caf-7777-47ef-a27a-70c4052a799f', '5e46d48e-82ff-45dc-9b4d-e68edb67cafc', 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab'::uuid, 'CWIW', 'CWSP', 'I241012079563', 2, 0, '250e7caf-7777-47ef-a27a-70c4052a799f', '2024-03-08 09:10:48.115', 'CDM-37719', '2024-03-13 12:26:24.928', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('3da66c8c-7754-4efa-81d3-db2aff666b09'::uuid, 'XXXX', '5e46d48e-82ff-45dc-9b4d-e68edb67cafc', 'ee147827-c892-4d56-8d77-0eb589ac7074', 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab'::uuid, 'CWSP', 'CWIW', 'I241012079563', 7, 0, '5e46d48e-82ff-45dc-9b4d-e68edb67cafc', '2024-03-07 16:01:03.094', '5e46d48e-82ff-45dc-9b4d-e68edb67cafc', '2024-03-08 09:10:48.115', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.routing
WHERE routingid in ('7132c4f5-d8aa-4ca7-ad5e-cf6654ac6035', '3da66c8c-7754-4efa-81d3-db2aff666b09');

select * from intakedastatus where intakenumber = 'I241012079563';

UPDATE cjams.intakedastatus
SET status=1,
updatedby = 'CDM-37719',
updatedon = now()
WHERE intakenumber = 'I241012079563';

select * from intakedastaging where intakenumber ='I241012079563'and activeflag =1;

UPDATE intakedastaging
SET 
updatedby = 'CDM-37719', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', 'null'))))
where intakenumber ='I241012079563'and activeflag =1;

update intakedastaging
set
updatedby = 'CDM-37719', updatedon = now(),
status = 'pending',
ispreintake = FALSE
where intakenumber ='I241012079563'and activeflag =1;

select * from intakesnapshot where intakenumber ='I241012079563';

UPDATE intakesnapshot
SET 
updatedby = 'CDM-37719', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
where intakenumber ='I241012079563'and activeflag =1;