/*
Issue Description: Case Closure Decision 
Category/Module: Bug
Root cause: There is a completed record in database which is inactive so making the record active is pulling the up record in decision tab
Fix provided:DB query to make the record active in routing
Data/Code fix ticket#: CJAMS-64910
Regression Impacts: N/A
Is Code fix Required?: CDM-44720
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/





INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('INDR', '07a546d5-9823-49d4-9167-5228b43e47d1', '2192e217-9285-4e41-a0fe-399b6e205dfc', 'c1f83444-d0eb-4ed4-8bfa-218173ca8b49'::uuid, 'CWSP', 'CWCW', 'a22d0a2e-7fb2-4fbc-85bc-dbe3d1d28c8e', 16, 1, '2192e217-9285-4e41-a0fe-399b6e205dfc', '2025-12-23 17:35:00', 'CJAMS-64910', NOW(), true, '', NULL, '', '251023169202', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);