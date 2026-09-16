/*
   Issue Description: CDM-41002 CPS case closure error. CPS case closed on 7/11/24 but Decision tab and recent Milestone Report shows as open
   Category/ Module  :Case Timeline
   Root cause: CPS Case closure record not showing in the decision tab due to roles issue and user tried to close the case before role data fix was made in CDM-39083.
   Fix provided : Data fix has been promoted to add closure record in the routing table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

--case number 241021982244
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES (gen_random_uuid(), 'INDR','2c18bafe-de1d-453d-9ba9-17077821c85f', '369b803f-90c3-4912-9db0-29cbaa221d81', '721d1433-69c6-47b6-ad55-d8c8f09360df', 'CWSP', 'CWCW', 'afe3341c-1291-44dd-a64a-d56b542fc9f3', 16, 1, 'CDM-41002', '2024-07-11 18:42:00.462Z', 'CDM-41002', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '241021982244', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

