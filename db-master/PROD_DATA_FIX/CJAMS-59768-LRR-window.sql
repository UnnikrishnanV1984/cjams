/*
Issue Description:251023025765:Please revise the LRR window drop down menus as follows:Alleged victim "Alleged victim unavailable > Attempted face to face > 5 or more attempts"Initial contact caregiver "Initial contact caregiver unavailable > Attempted face to face > 5 or more attempts"
Root cause: Over due button was missing updated it.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-60788
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:CIDM-10467
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
INSERT INTO cjams.cpsresponsetimeractions
(cpsresponsetimeractionsid, intakeserviceid, cpsresponsetimeractiontype, allegedvictimcontact, initialcaregivercontact, otherchildrencontact, insertedby, insertedon, updatedby, updatedon, activeflag, isskipped, cpsresponsetimerreason1, cpsresponsetimerreason2, cpsresponsetimerreason3, cpsresponsetimerreason4, cpsresponsetimerreason5, cpsresponsetimerreason6, cpsresponsetimerreason7, cpsresponsetimerreason8, cpsresponsetimerreason9, caseworkercomments, supervisorcomments, reason)
VALUES(gen_random_uuid(), '44d32200-d030-4791-bef4-35006586418f', 'Save', 'false', 'false', 'true', '2e31898b-ed3d-48b3-b5f8-b48120ef8a36', '2025-04-07 08:00:00', 'CJAMS-59768', '2025-04-07 08:00:00', 1, false, 'VAVU', 'VAFF', 'V5MF', NULL, NULL, NULL, 'CCCN', 'CFFN', 'C5MF',NULL , NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'CPSRTSV', '2e31898b-ed3d-48b3-b5f8-b48120ef8a36', 'e99f592f-ebb4-400c-ac4b-374c09ceaf50', '0b9d1ce0-198f-4cf2-b678-e2017669c119', 'CWCW', 'CWSP', (select cpsresponsetimeractionsid from cpsresponsetimeractions where updatedby  = 'CJAMS-59768'), 15, 0, '2e31898b-ed3d-48b3-b5f8-b48120ef8a36', '2025-04-07 08:00:00', 'CJAMS-59768', '2025-04-07 08:00:00', true, 'CPS Response Timer Save Request to Supervisor', NULL, 'CPS Response Timer Save Request to Supervisor', '251023000800', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'CPSRTSV', 'e99f592f-ebb4-400c-ac4b-374c09ceaf50', '2e31898b-ed3d-48b3-b5f8-b48120ef8a36', '0b9d1ce0-198f-4cf2-b678-e2017669c119', 'CWCW', 'CWSP', (select cpsresponsetimeractionsid from cpsresponsetimeractions where updatedby  = 'CJAMS-59768'), 16, 1, 'e99f592f-ebb4-400c-ac4b-374c09ceaf50', '2025-04-07 08:00:00', 'CJAMS-59768', '2025-04-07 08:00:00', true, 'CPS Response Timer Save Request to Supervisor', NULL, 'CPS Response Timer Save Request to Supervisor', '251023000800', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
