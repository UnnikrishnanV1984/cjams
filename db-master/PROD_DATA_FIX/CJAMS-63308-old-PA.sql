/*
  Issue Description:  As per system design, When there is a review/returned Purchase Authorization in the open service log, the edit button will not visible until the purchase authorization get approved/denied.
    In this case, the respective purchase authorization has been denied by the Fiscal Supervisor on 04/23/2020 but the status is still showing as Pending Payment Approval.
   Category/ Module  : service log  
   Root cause: The Purchase Auth ID: 1732706 with Auth End Date: 12/31/2019 is migrated from the lagacy system and there is no any payment associated with it
    Datafix to remove the pending approval can fix this issue that is preventing the user to end the service log from their end.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b68ea93e-0d66-4c6c-bea1-03c7495ebe10', 'PCAUTHR', 'e68284b1-b8c5-4091-94e3-2894b0ebafbc', NULL, 'af5a6281-0f7c-497b-a592-60b6359794c6', 'FNSFS', 'FNSFS', '1732706', 41, 1, 'e68284b1-b8c5-4091-94e3-2894b0ebafbc', '2020-06-08 08:53:32.430', 'e68284b1-b8c5-4091-94e3-2894b0ebafbc', '2020-06-08 08:53:32.430', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', '3283014', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='b68ea93e-0d66-4c6c-bea1-03c7495ebe10';
	
update routing
set activeflag = 1,
	updatedby = 'CJAMS-63308',
	updatedon = now()
where routingid = 'e8efceb5-1350-4a3d-83cf-de1f72041837'
	and routingstatustypeid = 62;