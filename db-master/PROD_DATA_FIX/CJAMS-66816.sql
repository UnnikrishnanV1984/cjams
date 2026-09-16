/*
Issue Description: The override referral is not being successfully routed for supervisor approval. Although intake #I261013993348 was submitted for approval, the request continues to appear in the In Progress status instead of moving to Pending Approval.
Category/Module:   CW – Intake Referrals Dashboard (Pending Review tab)
Root Cause: When the intake was submitted for approval, the userRole value in the request payload was blank. Because of this, the routing logic incorrectly defaulted to the Supervisor role instead of the Intake Worker role. As a result, the routing table did not insert the required approval record, preventing the request from progressing to the supervisor's queue.
Fix provided: Inserted the missing routing entry directly into the database to ensure the inatke is properly sent for supervisor approval.
Data/Code fix ticket#: CJAMS-66816
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
*/


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(cjams.gen_random_uuid(), 'INTR', '47dc653d-9089-4b47-b40e-0168ef6c2321', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b'::uuid, 'CWIW', 'CWSP', 'I261013993348', 1, 1, 'CJAMS-66816', '2026-04-02 15:44:21.397', 'CJAMS-66816', '2026-04-02 15:44:21.397', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', '', NULL);