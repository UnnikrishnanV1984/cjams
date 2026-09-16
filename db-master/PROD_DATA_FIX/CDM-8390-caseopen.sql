INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('7a66fb71-8b12-4e9a-b779-fbd0f44f4089', 'beb36f19-78ec-4104-a704-984a3b1fda82', now(), 'Open', 'Inprogress', '', now(), 1, '87b6e6b3-b6d0-48aa-9554-d4a048c2818f', now(), '87b6e6b3-b6d0-48aa-9554-d4a048c2818f', now(), null, null, null, null);
	
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'SCDR', 'ef3affc6-c4db-447c-b057-1588c38ccf42', '87b6e6b3-b6d0-48aa-9554-d4a048c2818f', null, 'CWSP', 'CWCW', '7a66fb71-8b12-4e9a-b779-fbd0f44f4089', 16, 1, 'ef3affc6-c4db-447c-b057-1588c38ccf42', 
now(), 'ef3affc6-c4db-447c-b057-1588c38ccf42', now(), false, '', null, null, null, null, null, null, null, null, null, null, null, null);

