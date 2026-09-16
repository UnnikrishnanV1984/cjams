/*
Issue Description: CJAMS-64241: Missing Case closure
Category/Module: Case closure
Root cause: Case closure request has been sent by "shaniqua.lee@maryland.gov" which has been deactivated
Fix provided: Data fix has been done to to insert records into routing table
Data/Code fix ticket#: CJAMS-64241
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error and user requested for the data fix.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




DELETE FROM cjams.routing
WHERE routingid='3634d0f2-b15b-44d7-bdc0-1da366e732f1';


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3634d0f2-b15b-44d7-bdc0-1da366e732f1', 'INDR', '07a546d5-9823-49d4-9167-5228b43e47d1', '2192e217-9285-4e41-a0fe-399b6e205dfc', 'c1f83444-d0eb-4ed4-8bfa-218173ca8b49', 'CWSP', 'CWCW', 'ae6a598d-65bd-4a24-9529-9a9abd405735', 16, 1, '2192e217-9285-4e41-a0fe-399b6e205dfc', '2025-12-23 17:49:23.000', 'CJAMS-64241', '2026-01-09 09:02:17.501', true, '', NULL, '', '251023151001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
