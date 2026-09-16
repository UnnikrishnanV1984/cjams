/*
Issue Description:Supervisor is selecting Return to Worker option and submitting the Placement Review.  
Getting the message 'Placement Returned to worker successfully' but the case is still showing up with 'Review' status
 and in the Approval Inbox of Supervisor.  
Category/Module: Bug
Root cause: User was not able to reject the placement as it is showing as return to worker successfully 
but that was never done because it is not getting updated in routing table 
Fix provided: DB queries to update record in routing, placementrevision, table. Working as expected
Data/Code fix ticket#: CJAMS-58588
Regression Impacts:Placement
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


update routing set activeflag = 0,
updatedby = 'CJAMS-58771',
updatedon = now()
where routingid = '95956818-5ac1-41dd-b24c-52b81a0b8371';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'PLTR', '3fefed76-7f38-4cf0-bf10-c8e31d604e08', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '091dfa7d-f371-40b6-8394-55984c940ad2', 'CWSP', 'CWCW', 'e9eb3e6b-2169-4156-9abe-3364db836fba', 17, 1, '3fefed76-7f38-4cf0-bf10-c8e31d604e08', '2025-03-19 07:02:00', '3fefed76-7f38-4cf0-bf10-c8e31d604e08', '2025-03-19 07:02:00', true, 'Child PlacementRejected', NULL, 'Child PlacementRejected', '2020036405072', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update placementrevision set status = 'Rejected', 
approvedby = 'ffaff6c5-0784-47e8-b29e-a04373e6cc89',
approveddate = '2025-03-19 07:30:00',
updatedby = 'CJAMS-58771',
updatedon = now()
where placementrevisionid = '5b29d6b6-48f1-43bc-83df-f63bc5a286fe';