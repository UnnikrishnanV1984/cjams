-- CDM-34575 - Adjust/Error Correction
/*
-- Issue Description: 
	Debit Error Correction transaction with missing routing record (Partial transaction)

-- Baltimore City
-- Client ID: 3453483 (ZYRIHANNA THOMPSON) - f08b4139-7b2f-43d2-a308-301ef0c9eb60
-- Conserved Account ID: 1017933
-- Transaction ID: 1227444	- Debit Adjustments - Error Correction - $841.00 

-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: The apporval record is missing in routing table (Partial transaction).
-- Fix Provided: Datafix has been promoted add the missing routing record.
--			     Please ask the Baltimore City finance supervisor Mekong Taylor to apporve this transaction.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To add the missing routing record (CDM-34575)
-- from: cory.whittington2@maryland.gov	Cory Whittington - a231e19d-54c7-4ea5-852d-c195bdc31485
-- To: mekong.taylor@maryland.gov	Mekong Taylor - 51c326e1-2d31-44a1-b78e-4a957a120138
-- 81	CACCERROR	Child Transation Error Correction

Delete from cjams.routing where insertedby = 'CDM-34575' and routingstatustypeid = 81;

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, 
		old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'CACCTRANS', 'a231e19d-54c7-4ea5-852d-c195bdc31485', '51c326e1-2d31-44a1-b78e-4a957a120138', 
		'31eabbb0-f686-41dc-94d3-a3c26b12043a', 'FNSFS', 'FNSFS', '1227444', 81, 1, 
		'CDM-34575', now(), 'CDM-34575', now(), true, 
		'Approved Error Correction for the Client Account ID(1017933)',
		NULL, 'Approved Error Correction for the Client Account ID(1017933)', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);
 
