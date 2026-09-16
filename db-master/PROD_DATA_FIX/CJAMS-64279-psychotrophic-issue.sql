/*
Issue: CJAMS-64279 Assign to review coordinator
Category/Module: Psychotrophic Dashboard 
Root cause: The Psychiatrist wrongly changed the status to 'Return To Worker' instead 'Return To Coordinator'. Need data fix to put the request back to Psychiatrist, so that the user can submit for 'Return to Coordinator'.
            Request ID: 3314
            Client Name: HEAVEN MARIE LEDNUM
            CJAMS PID: 3378426
Fix provided:  Data fix has been done to put the request back to Psychiatrist, so that the user can submit for 'Return to Coordinator'.
Data/Code fix ticket#: CJAMS-64279
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix is needed to resolve it.
*/

--Making the previous routing record active Pending CAP Review Active
update routing 
set activeflag = 1,
    updatedon = now(),
    updatedby = 'CJAMS-64279'
where routingid = '456e40cc-ef0f-408d-ae57-a56dcaae5b5e'
and objectid = 'c66c0361-22ed-40e5-8bca-373a1456bd47' ;

--Deleting the return to worker routing record which sent by mistake.


-- Backup for deleted record
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('c2541933-c197-4b1c-9bbe-f122e5f48cd1', 'PSY', '35f46878-57e3-4476-a7a7-18444da836b5', 'd8a2c4ce-3d4e-47d2-9abb-a3a32eadc293', '78f8a3cf-1613-49ac-8b26-74d7276f48d0', 'CWPSYPSYCH', 'CWCW', 'c66c0361-22ed-40e5-8bca-373a1456bd47', 904, 1, '35f46878-57e3-4476-a7a7-18444da836b5', '2025-12-29 12:00:45.510', NULL, '2025-12-29 12:00:45.510', false, NULL, NULL, 'unable to leave voicemail', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete from routing   
where routingid = 'c2541933-c197-4b1c-9bbe-f122e5f48cd1'
and objectid='c66c0361-22ed-40e5-8bca-373a1456bd47'; 