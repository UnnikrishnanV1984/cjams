-- CDM-28105 - LOST PURCHASE AUTHORIZATION
/*
-- Issue Description: 
   Finance worker and Supervisor cannot locate pending purchase authorization.
   
-- Case ID: 3193098
-- Client ID: 3127840 (GISSELL ORELLANA) - 2ec2547f-d161-4a0e-b93c-5055d3a5285a
-- Provider ID: 5089039	(COMPASS Forensic Assessments and Treatment)
-- Auth ID: 1856572 - 09/01/2022 To 09/30/2022 - $950.00 - Mental Health-Counseling (Paid) 
-- Montgomery County 

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Partial Transaction issue, Authorization table is saying Funding approved and routing table is missing data.
-- Fix Provided: Datafix has been provided to show the Purchase Authorization on Finance dashboard.
--				Please ask the Montgomery County Finance Supervisor complete the Funding approval.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix the Service Purchase Authorization Partial Transaction issue
select authorization_id, 
	sprvsr_approval_status_cd,
	sprvsr_approval_dt,
	ads_approval_status_cd,
	ads_approval_dt,
	funding_approval_status_cd, 
	funding_approval_dt, 
	payment_approval_status_cd,
	payment_approval_dt,
	update_ts, 
	update_user_id
from tb_service_purchase_authorization 
where authorization_id = 1856572
	and delete_sw = 'N'
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set funding_approval_status_cd = NULL,
	funding_approval_dt = NULL,
	update_ts = now(), 
	update_user_id = 'CDM-28105'
where authorization_id = 1856572
	and delete_sw = 'N'
	and payment_approval_status_cd is null ;

	
select routingid, routingstatustypeid, remarks, objectid, activeflag, updatedby, updatedon
	from routing 
where objectid  = '1856572'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;	
	

-- Delete all Returned records
/*
1	850	Returned	ce87c4e6-5b25-4c8a-8dc2-58f885dfce07
1	850	Returned	2ef4a36c-8d1a-46fc-a6cb-0e69fd732083
1	850	Returned	9c282173-64ad-4176-ad89-2aaaa086d466
1	850	Returned	218a243a-e4b5-4125-89cc-ac2bb751b084
1	850	Returned	e5242112-bfb9-4391-8472-fff8a2b0f286
1	850	Returned	60502fdf-799b-4dab-be97-56a164a64dac
1	850	Returned	39f28f1f-56ec-48fa-bd73-c1b3f6a1174c
*/	

delete from routing 
where objectid = '1856572'
	and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
	and routingid in ( 	'ce87c4e6-5b25-4c8a-8dc2-58f885dfce07',
						'2ef4a36c-8d1a-46fc-a6cb-0e69fd732083',
						'9c282173-64ad-4176-ad89-2aaaa086d466',
						'218a243a-e4b5-4125-89cc-ac2bb751b084',
						'e5242112-bfb9-4391-8472-fff8a2b0f286',
						'60502fdf-799b-4dab-be97-56a164a64dac',
						'39f28f1f-56ec-48fa-bd73-c1b3f6a1174c'
					) ;

/*
-- To Revert if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2ef4a36c-8d1a-46fc-a6cb-0e69fd732083', 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '1856572', 850, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-10 14:31:51.430', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-10 14:31:51.430', true, 'Returned', NULL, 'will not let me approve', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('9c282173-64ad-4176-ad89-2aaaa086d466', 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '1856572', 850, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-10 14:31:11.175', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-10 14:31:11.175', true, 'Returned', NULL, 'will not let me approve', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ce87c4e6-5b25-4c8a-8dc2-58f885dfce07', 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '1856572', 850, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-10 14:33:58.743', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-10 14:33:58.743', true, 'Returned', NULL, 'will not let me approve', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('39f28f1f-56ec-48fa-bd73-c1b3f6a1174c', 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '1856572', 850, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-07 17:01:29.202', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-07 17:01:29.202', true, 'Returned', NULL, 'will not let me approve', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('60502fdf-799b-4dab-be97-56a164a64dac', 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '1856572', 850, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-07 17:01:57.823', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-07 17:01:57.823', true, 'Returned', NULL, 'will not let me approve', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('218a243a-e4b5-4125-89cc-ac2bb751b084', 'PCAUTHR', '390fe84f-bf06-4f80-9795-065f4d170df3', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWCW', 'FNSFS', '1856572', 850, 1, '390fe84f-bf06-4f80-9795-065f4d170df3', '2022-10-10 09:05:09.980', '390fe84f-bf06-4f80-9795-065f4d170df3', '2022-10-10 09:05:09.980', true, 'Returned', NULL, 'will not let me approve', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e5242112-bfb9-4391-8472-fff8a2b0f286', 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'f4037169-c70f-422e-8a3b-e9385f5065f9', 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '1856572', 850, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-07 17:02:27.276', 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2022-10-07 17:02:27.276', true, 'Returned', NULL, 'will not let me approve', '3193098', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/ 	