-- CDM-36273 - Missing Service Auths
/*
-- Issue Description: 
   Two service authorizations are not showing in funding approval. 
   
Case # 231030167645
Client ID# 201268682 (Wallace Snyder)
Purchase Auth # 2825279
Provider ID# 5046696 (Serenity Treatment Center, Inc.)

Case # 221030016009
Client ID# 4366202 (ASHLEY BYINGTON)
Purchase Auth # 2833104
Provider ID# 5046696 (Serenity Treatment Center, Inc.)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Routing Data Issue. 
-- Fix Provided: Datafix has been promoted to fix the Purchase Authorization Routing data.
-- Please ask any Washington County Finance user to complete the Funding Approval.        
-- Pull request# N/A
-- Reason why no related code fix: (Error happened due to code issue, which was fixed with CDM-36024 & moved to Prod on 22/Dec/23   
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- To fix the Purchase Authorization Routing data (CDM-36273)
select authorization_id, service_log_id, 
	sprvsr_approval_status_cd, sprvsr_approval_dt,
	ads_approval_status_cd, ads_approval_dt,
	funding_approval_status_cd, funding_approval_dt,
	payment_approval_status_cd, payment_approval_dt,
	delete_sw, update_ts, update_user_id 
from tb_service_purchase_authorization 
where authorization_id in ( 2825279, 2833104) 
	and delete_sw = 'N'
	and payment_approval_status_cd is null ;
	
update tb_service_purchase_authorization 	
set funding_approval_status_cd = NULL,
	funding_approval_dt = NULL,
	update_ts = now(), 
	update_user_id = 'CDM-36273'
where authorization_id in ( 2825279, 2833104) 
	and delete_sw = 'N'
	and payment_approval_status_cd is null ;


-- Delete incorrect routing records 
-- 2825279	1	41	Forwarded to Payment Approval	efa13d56-44db-42cb-9cf7-7f1476650a63
select objectid, routingid, routingstatustypeid, remarks, updatedby, updatedon  
	from routing 
where routingid = 'efa13d56-44db-42cb-9cf7-7f1476650a63' ;
	
delete from routing
where routingid = 'efa13d56-44db-42cb-9cf7-7f1476650a63' ;

-- 2833104	1	41	Forwarded to Payment Approval	45556782-c945-4250-9fda-c5a1b2e065ee
select objectid, routingid, routingstatustypeid, remarks, updatedby, updatedon  
	from routing 
where routingid = '45556782-c945-4250-9fda-c5a1b2e065ee' ;

delete from routing
where routingid = '45556782-c945-4250-9fda-c5a1b2e065ee' ;

-- To Revert if needed
/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('efa13d56-44db-42cb-9cf7-7f1476650a63', 'PCAUTHR', '753c40c4-34fd-4e88-9e2a-f974a416d51a', NULL, '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'FNSFS', 'FNSFS', '2825279', 41, 1, '753c40c4-34fd-4e88-9e2a-f974a416d51a', '2023-12-11 08:52:06.196', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '2023-12-11 08:52:06.196', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('45556782-c945-4250-9fda-c5a1b2e065ee', 'PCAUTHR', '753c40c4-34fd-4e88-9e2a-f974a416d51a', NULL, '5e5ec749-3791-4cc7-ad32-cf85b0c52d74', 'FNSFS', 'FNSFS', '2833104', 41, 1, '753c40c4-34fd-4e88-9e2a-f974a416d51a', '2023-12-13 16:09:31.795', '753c40c4-34fd-4e88-9e2a-f974a416d51a', '2023-12-13 16:09:31.795', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/