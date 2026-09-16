-- CDM-22493 - Daycare Payment
/*
-- Issue Description: 
   Supervisor sent payment for approval it still shows $832 pending my approval.

-- Case ID: 202109006946
-- Client ID: 200648424	(Haizyn Fox-Gonzalez) - 74d8ee85-3f8c-4559-9574-0f656577d34d
-- Service Log ID: 2041603 - Child Care (Paid) 
-- Provider ID: 5070582	(Impact Child Development Center)
-- Authorization ID: 1830903 - 04/04/2022 To 04/29/2022 - $832.00

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
/*
-- Only if active
1	40	Forwarded to Funding Approval	0d9f3ca4-52c1-4858-b7fb-90200acf1102	PCAUTHR
1	40	Forwarded to Funding Approval	5aaae47f-d4c3-47ec-83e9-347a7b7cfa71	PCAUTHR
1	39	Forwarded to Case Supervisor	7c9b4548-47d8-4a9f-b96c-32108f6a4e01	PCAUTH
*/

select *
	from routing 
where routingid 
	in (	'0d9f3ca4-52c1-4858-b7fb-90200acf1102',
			'5aaae47f-d4c3-47ec-83e9-347a7b7cfa71',
			'7c9b4548-47d8-4a9f-b96c-32108f6a4e01'
		)
	and objectid = '1830903'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid 
	in (	'0d9f3ca4-52c1-4858-b7fb-90200acf1102',
			'5aaae47f-d4c3-47ec-83e9-347a7b7cfa71',
			'7c9b4548-47d8-4a9f-b96c-32108f6a4e01'
		)
	and objectid = '1830903'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7c9b4548-47d8-4a9f-b96c-32108f6a4e01', 'PCAUTH', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '44ae52aa-6389-425a-a422-2a8bf24c3aae', 'dbbc2a6e-0368-47ee-83bb-455d1f331129', 'CWCW', 'CWSP', '1830903', 39, 1, '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-05-04 12:54:51.937', '8180f7f9-62cf-45aa-8953-43bb5c4a2473', '2022-05-04 12:54:51.937', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '202109006946', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0d9f3ca4-52c1-4858-b7fb-90200acf1102', 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089', 'CWSP', 'FNSFW', '1830903', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-05-09 10:19:25.164', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-05-09 10:19:25.164', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109006946', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5aaae47f-d4c3-47ec-83e9-347a7b7cfa71', 'PCAUTHR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', NULL, 'bc302d60-d8a2-45ca-8e1c-73ac0d800089', 'CWSP', 'FNSFW', '1830903', 40, 1, '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-05-05 18:12:31.379', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '2022-05-05 18:12:31.379', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202109006946', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
