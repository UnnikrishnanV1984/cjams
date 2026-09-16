-- CDM-24080 - Assistance in clearing funding requests
/*
-- Issue Description: 
	User request to Deny 2 Purchase Authorizations from 2020 period

-- Case ID: 3298645
-- Client ID: 3971194 (JAMIE SNYDER) - d74f3a91-db67-4ddc-a748-1276a51c5b0fs
   
-- Category/ Module: Purchase Authorization (Case Management) 
-- Root cause: Migrated Data
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Child Care (Paid)
-- Provider ID: 5081725	(Creative Management Corporation)
-- Authorization ID: 758901 - 04/01/2020 To 04/30/2020 - $504.00
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
	(	gen_random_uuid()::uuid, 'PCAUTH', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', 
		'00000000-0000-0000-0000-000000000000', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a'::uuid, 
		'FNSFS', 'FNSFS', '758901', 62, 1, 
		'CDM-24080', now(), 'CDM-24080', now(), 
		true, 'Denied', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
select eventcode, activeflag, objectid, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.routingid = 'bbcb8cfb-3fd5-484f-9c63-b6365f015978'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24080',
	ro.updatedon = now()	
where ro.routingid = 'bbcb8cfb-3fd5-484f-9c63-b6365f015978'
	and ro.activeflag = 1 ;	


select funding_approval_dt, funding_approval_status_cd, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where delete_sw = 'N'
	and authorization_id = 758901 ;
	
update tb_service_purchase_authorization
set funding_approval_dt = current_date,
	funding_approval_status_cd = '3281',
	update_user_id = 'CDM-24080',
	update_ts = now()	
where delete_sw = 'N'
	and authorization_id = 758901 ;

	
-- Child Care (Paid)
-- Provider ID: 5097114	(SKC Early Education Center Largo)
-- Authorization ID: 1736432 - 06/01/2020 To 06/30/2020 - $504.00 

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
	(	gen_random_uuid()::uuid, 'PCAUTH', '90849668-3008-4027-bc25-c357594f0710', 
		'144b922e-bc2c-4b1a-8048-d479256caa15', 'abf11605-707e-457d-9f07-6a31abca13d7'::uuid, 
		'FNSFS', 'FNSFS', '1736432', 62, 1, 
		'CDM-24080', now(), 'CDM-24080', now(), 
		true, 'Denied', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

select eventcode, activeflag, objectid, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.routingid = '62f92e2c-4b0f-48e8-8605-ee32c2d35c8e'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-24080',
	ro.updatedon = now()	
where ro.routingid = '62f92e2c-4b0f-48e8-8605-ee32c2d35c8e'
	and ro.activeflag = 1 ;	
	
select funding_approval_dt, funding_approval_status_cd, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where delete_sw = 'N'
	and authorization_id = 1736432 ;
	
update tb_service_purchase_authorization
set funding_approval_dt = current_date,
	funding_approval_status_cd = '3281',
	update_user_id = 'CDM-24080',
	update_ts = now()	
where delete_sw = 'N'
	and authorization_id = 1736432 ;
