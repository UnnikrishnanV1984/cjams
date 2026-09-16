-- CDM-30837
/*
-- Case ID: 3203360
-- Client ID: 3263754 (PERRIS STREET)
-- Category/ Module: Purchase Authorization (Case Management) 
-- Root cause: Migrated Data
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Child Care (Paid)
-- Provider ID: 5091787	
-- Authorization ID: 708033 - 05/06/2019  TO 05/20/2019 - $453.28
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid()::uuid, 'PCAUTH', '00000000-0000-0000-0000-000000000000', 
		'337f4170-0f0c-4675-9430-accd7771590e', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a'::uuid, 
		'FNSFS', 'FNSFS', '708033', 62, 1, 
		'CDM-30837', now(), 'CDM-30837', now(), 
		true, 'Denied', NULL, NULL, NULL,    
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
select eventcode, activeflag, objectid, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.routingid = '0d722db0-7a95-4548-8a1b-b56a22e1a75b'
	and ro.activeflag = 1 ;	
	
update routing ro
set activeflag = 0,
	updatedby = 'CDM-30837',
	updatedon = now()	
where ro.routingid = '0d722db0-7a95-4548-8a1b-b56a22e1a75b'
	and ro.activeflag = 1 ;	


select funding_approval_dt, funding_approval_status_cd, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where delete_sw = 'N'
	and authorization_id = 708033 ;
	
update tb_service_purchase_authorization
set funding_approval_dt = current_date,
	funding_approval_status_cd = '3281',
	update_user_id = 'CDM-30837',
	update_ts = now()	
where delete_sw = 'N'
	and authorization_id = 708033 ;