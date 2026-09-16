/*
Issue Description: Case Closure Decision 
Category/Module: Bug
Root cause: There is a completed record in database which is inactive so making the record active is pulling the up record in decision tab
Fix provided:DB query to make the record active in routing
Data/Code fix ticket#: CIDM-11140
Regression Impacts: N/A
Is Code fix Required?: CDM-44720
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INDR', '07a546d5-9823-49d4-9167-5228b43e47d1', '7320a470-1ffb-41e8-ae98-8175d734aa33', 'c1f83444-d0eb-4ed4-8bfa-218173ca8b49'::uuid, 'CWSP', 'CWCW', '4f77225a-3f71-4473-a8b9-d8f187dc0c94', 16, 1, '7320a470-1ffb-41e8-ae98-8175d734aa33', '2026-01-06 15:38:20.916', 'CIDM-11140', NOW(), true, '', NULL, '', '251023174374', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


