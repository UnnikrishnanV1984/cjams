-- CDM-23078 - Payment still shows as Pending
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 3284563
-- Client ID: 4109878 (IMIYA CHRISTIAN) - c7dafb5f-ffdd-4a4d-bd8f-98bd80a0238d
-- Service Log ID: 2031675 - Special Education (Paid) 
-- Provider ID: 5041606 (Specialized Education of MD, Inc.)
-- Authorization ID: 1818375 - 01/01/2022 To 01/31/2022 - $3563.64

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1 39	Forwarded to Case Supervisor	20930695-07cf-4314-bb19-df3810e2a0b3	PCAUTH
select *
	from routing 
where routingid = '20930695-07cf-4314-bb19-df3810e2a0b3'
	and objectid = '1818375'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid = '20930695-07cf-4314-bb19-df3810e2a0b3'
	and objectid = '1818375'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('20930695-07cf-4314-bb19-df3810e2a0b3'::uuid, 'PCAUTH', 'fcb353c5-30db-4bb7-96fb-cdc67404c643', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', 'c9b3e450-39fc-4f06-941f-3fc8d89f8ce3'::uuid, 'CWCW', 'CWSP', '1818375', 39, 1, 'fcb353c5-30db-4bb7-96fb-cdc67404c643', '2022-02-10 09:48:42.986', 'fcb353c5-30db-4bb7-96fb-cdc67404c643', '2022-02-10 09:48:42.986', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3284563', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/	
