/*
   Issue Description: CDM-38966
   Category/ Module  : Permanency plan
   Root cause:Child was selected as not turning 18 before next review, which was incorrect.  Attempted to deny this annual review, but it was already approved.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


delete from routing 
where objectid = '74f6e1cd-d0ac-4ca9-897f-13348bca1b47'
and eventcode = 'GAYR';

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8934a980-564d-452c-805f-61703423af5d', 'GAYR', 'edbc2679-a18c-4539-9eb6-62a4299183f3', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '74f6e1cd-d0ac-4ca9-897f-13348bca1b47', 16, 1, 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:34:51.781', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:34:51.781', true, '', NULL, 'Annual Review Submitted for review', '3165116', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e224882d-7d80-4a4d-a3fd-e82b75845fba', 'GAYR', 'edbc2679-a18c-4539-9eb6-62a4299183f3', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '74f6e1cd-d0ac-4ca9-897f-13348bca1b47', 16, 1, 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:34:51.781', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:34:51.781', true, '', NULL, 'Annual Review Submitted for review', '3165116', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('333f3dfb-ad1f-43c7-b52a-8c4d6cc11b0b', 'GAYR', 'edbc2679-a18c-4539-9eb6-62a4299183f3', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '74f6e1cd-d0ac-4ca9-897f-13348bca1b47', 15, 0, 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:33:12.785', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:33:12.785', true, 'Annual Review Submitted for review', NULL, '', '3165116', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('9173b137-ff24-4ce4-8deb-178d143bf525', 'GAYR', 'edbc2679-a18c-4539-9eb6-62a4299183f3', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '74f6e1cd-d0ac-4ca9-897f-13348bca1b47', 15, 0, 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:33:12.785', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:34:51.781', true, 'Annual Review Submitted for review', NULL, '', '3165116', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d9d33abc-2571-43a5-a967-996fb2a36fd3', 'GAYR', 'edbc2679-a18c-4539-9eb6-62a4299183f3', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '74f6e1cd-d0ac-4ca9-897f-13348bca1b47', 15, 0, 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:32:44.636', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:32:44.636', true, 'Annual Review Submitted for review', NULL, '', '3165116', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d4d8fcb4-0dc5-443a-94eb-81de984f4bd9', 'GAYR', 'edbc2679-a18c-4539-9eb6-62a4299183f3', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '74f6e1cd-d0ac-4ca9-897f-13348bca1b47', 15, 0, 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:32:44.636', 'edbc2679-a18c-4539-9eb6-62a4299183f3', '2024-05-10 10:32:44.636', true, 'Annual Review Submitted for review', NULL, '', '3165116', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/