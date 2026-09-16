-- CDM-19891 - Purchase auth in system after approval
/*
-- Issue Description: 
   Purchase Authorization with duplicate routing records 

-- Case ID: 3123412
-- Client ID: 1697633 (ERICA D ANDERSON) - 58b60595-86ca-402c-8c82-5161e22bb9d5
-- Provider ID: 5036607	(Baltimore City Department of Social Services)
-- Authorization ID: 1804030 - 07/01/2021 To 07/15/2021 - $1134.00
-- Rent Payments/Deposit (Paid) 


-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	43	Approved	276bb357-43db-4230-b493-366408fc5700
select *
	from routing 
where routingid = '276bb357-43db-4230-b493-366408fc5700'
	and objectid = '1804030'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid = '276bb357-43db-4230-b493-366408fc5700'
	and objectid = '1804030'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('276bb357-43db-4230-b493-366408fc5700'::uuid, 'PCAUTHR', '55cc5a5b-e268-4316-bffd-26e086d57285', '676ac1ec-f338-4646-a786-b3af379986f9', '2546af4b-b0f4-4b5f-a21f-5d27602a7c9d'::uuid, 'CWSP', 'FNSFS', '1804030', 43, 1, '55cc5a5b-e268-4316-bffd-26e086d57285', '2021-11-12 17:55:06.622', '55cc5a5b-e268-4316-bffd-26e086d57285', '2021-11-12 17:55:06.622', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3123412', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/	

