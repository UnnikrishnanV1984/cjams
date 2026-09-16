/*
Issue Description: 
Root cause: Case assignment was deactivated for changes related to CIDM-9543 and the pending case closure record is also deactivated
Fix provided: Data fix update the case assignment
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Code fix ticket#: N/A
Reason why no related code fix: User Error.
*/



INSERT INTO cjams.routing
( routingid , eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( '8943636f-d547-45aa-9ce8-81900038d073', 'INDR','9ebab84a-8f1d-4e43-9456-e1873e286808', '7280533c-d989-41db-aafa-d6cc4879f8d9', '2083200e-1403-4c14-8788-0a6937c2122f', 'CWSP', 'CWCW', '62ae5413-38a3-4d45-b362-8ef1a6dd1c36', 16, 1, '9ebab84a-8f1d-4e43-9456-e1873e286808', '2025-12-15 11:49:09.640', 'CJAMS-64387', now(), true, '', NULL, '', '251023151605', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) on conflict do nothing;


-- 2025-12-31 11:10:00
update caseassignment set enddate = '2025-12-15 11:49:09.640', updatedby = 'CJAMS-64387', updatedon = now()
where caseassignmentid in ('559c4c21-1318-48ab-b490-1715fa68ccf5', '881b06ce-e664-4fd7-bb5a-fa58fd6487fd');

