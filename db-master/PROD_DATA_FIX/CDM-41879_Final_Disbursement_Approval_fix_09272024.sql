-- CDM-41879 - Final Disbursement
/*
-- Issue Description: 
   User request to reroute the Final Disbursement approval from Zachariah Avirah to Michelle Goodman.

-- Client ID: 3886792 (CAMERON Alexander MILLER) - f5778291-939e-4847-8aa6-cb67a208e973
-- Conserved Account ID: 13766
-- Disbursement IdD: 1035904 - $7313.00 - 101 (Final Disbursement)
  
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User request to reroute the Final Disbursement approval from Zachariah Avirah to Michelle Goodman
-- 			   as the user is out on medical leave. Data fix needs to done to approve the Funding Disbursement 
			   and send it to Kimberly for Payment Disbursement.As of now, there is a limitation in CJAMS for that 
			   kind of primary role so we need to fix the code so you Michelle can approve funding disbursement 
			   and send it to Kimberly for Payment Disbursement.
-- Fix Provided: Datafix has been promoted to reroute the Final Disbursement approval to Michelle Goodman and also to approve the Funding Disbursement 
			   and send it to Kimberly for Payment Disbursement.
-- Pull request# for code fix: CIDM-9572
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- To reroute the Final Disbursement approval (CDM-41879) 
-- Currently Forwarded to Zacharia Avirah  (zacharia.avirah3@maryland.gov) - a3aa90d2-5955-47e9-84db-55a8129f15cb
-- To forward approval to Michelle Goodman (michelle.goodman@maryland.gov) - 38f661bb-a9de-4060-87cd-f0dac7d840e7
-- Approve the Funding Disbursement as Michelle Goodman and send it to Kimberly for Payment Disbursement.

update routing
set tosecurityusersid = '38f661bb-a9de-4060-87cd-f0dac7d840e7',
	activeflag = 0,
	updatedby = 'CDM-41879',
	updatedon = now()
where objectid = '1035904'
	and eventcode = 'FINALDIS' -- Final Disbursement transaction
	and routingstatustypeid = 56
	and activeflag = 1 ;

--Update routing to add Funding approval record
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'FINALDIS', '38f661bb-a9de-4060-87cd-f0dac7d840e7', '70b2ef51-f4a3-43bc-9d87-e3b0c465b79b', '48661136-51fe-4e97-ac66-1a0a658678cb'::uuid, 'FNSFS', 'FNSFS', '1035904', 57, 1, 'CDM-41879', now(), 'a3aa90d2-5955-47e9-84db-55a8129f15cb', '2024-10-07 13:27:04.694', true, 'Forwarded to Payment Approval', NULL, 'Final Disbursement Forwarded to Payment Approval', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


update tb_child_account_disbursement
set funding_approval_status = '3047',
	payment_approval_status = '3045',
	update_ts = now(),
	update_user_id = 'CDM-41879'
where disbursement_id = 1035904;