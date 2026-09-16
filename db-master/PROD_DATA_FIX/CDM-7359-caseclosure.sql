			
delete from cjams.intakeservicerequestdispositioncode
where intakeservicerequestdispositioncodeid in ('70ec56a9-0e36-4884-8d9b-7137beae0eb3',
		'b4c046e5-8b66-4051-877f-39b8a8993fbe',
		'efef74fc-805f-465a-87dd-a2d84cd88c64');
	
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'INDR', '7f396b01-465f-452f-b495-599215ab5998', '9e3a48d8-d0d5-413d-923f-2201d9648c7d', '8c40c893-2515-41f1-8576-016dfb766afb', 'CWSP', 'CWCW', '63c4940c-cbf4-498e-baa7-c30d6ba70515', 16, 1, 'CDM-7359', '2020-09-08 17:44:10', 'CDM-7359','2020-09-08 17:44:10', false, 'Disposition Approved', null, 'Disposition Approved', 'CW2955636', null, null, null, null, null, null, null, null, null);

		