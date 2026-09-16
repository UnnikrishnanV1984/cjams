/*
   Issue Description: 3102144:Greetings,This request is because the service log has a funding authorization that is approved when downloaded but appears in CJAMS as unapproved by finance.
   Category/ Module  : service log
   Root cause: Removing Pending funding Approval Record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('be46f0d5-fd8e-4370-8ed4-6af6740f32fc'::uuid, 'PCAUTHR', 'f0252f90-f539-4e4b-ba6f-7518d21146cf', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a'::uuid, 'CWSP', 'FNSFS', '1808251', 40, 1, 'f0252f90-f539-4e4b-ba6f-7518d21146cf', '2022-10-06 10:27:43.471', 'f0252f90-f539-4e4b-ba6f-7518d21146cf', '2022-10-06 10:27:43.471', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3102144', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='be46f0d5-fd8e-4370-8ed4-6af6740f32fc'::uuid;

update routing 
set activeflag = 1,
	updatedby = 'CJAMS-63031',
	updatedon = now()
where routingid = '521c57d9-4ded-4fc8-bcd5-a915ac9fdd54'
	and activeflag = 0
	and routingstatustypeid = 43;