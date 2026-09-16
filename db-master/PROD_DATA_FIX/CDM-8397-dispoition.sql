
		
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('88fe7033-0f47-47b0-9ee9-cacf79b906f4', 'c9b66829-d09a-4460-873a-9e1d9e729414', now(), 'Open', 'Inprogress', '', now(), 1, '056865a7-2a58-494e-9993-ccc6fd9aae58', now(), '056865a7-2a58-494e-9993-ccc6fd9aae58', now(), null, null, null, null);
	
			
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'SCDR', '056865a7-2a58-494e-9993-ccc6fd9aae58', '00000000-0000-0000-0000-000000000000', null, 'CWSP', 'CWCW', '88fe7033-0f47-47b0-9ee9-cacf79b906f4', 16, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', 
now(), 'e155e2c1-d335-49f4-9450-22382b37e120', now(), false, '', null, null, null, null, null, null, null, null, null, null, null, null);
	