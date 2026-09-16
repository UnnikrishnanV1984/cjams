-- CJAMS-59770  LRR Window Revision
/*
--	Issue Description: 
	display the overdue reason button with the following values,

Alleged victim - Alleged victim unavailable > Attempted face to face > 5 or more attempts
ICC - Initial contact caregiver unavailable > Attempted face to face > 5 or more attempts
Submission history:
Case worker: Tamarra Smith
Supervisor: Katie Berans
Updated on and Approval date - 5/21/25 4:39 PM

-- Category/ Module: Contact Notes 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to display the overdue reason button 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

delete from cpsresponsetimeractions where updatedby = 'CJAMS-59770';

delete from routing where updatedby = 'CJAMS-59770';
 
INSERT INTO cjams.cpsresponsetimeractions
(cpsresponsetimeractionsid, intakeserviceid, cpsresponsetimeractiontype, allegedvictimcontact, initialcaregivercontact, otherchildrencontact, insertedby, insertedon, updatedby, updatedon, activeflag, isskipped, cpsresponsetimerreason1, cpsresponsetimerreason2, cpsresponsetimerreason3, cpsresponsetimerreason4, cpsresponsetimerreason5, cpsresponsetimerreason6, cpsresponsetimerreason7, cpsresponsetimerreason8, cpsresponsetimerreason9, caseworkercomments, supervisorcomments, reason)
VALUES(gen_random_uuid(), '4de220f1-87fa-4c93-bcdc-d4c55b42d26d', 'Save', 'false', 'false', 'true', '303f7300-613a-488a-bea0-d7fd382ab705', '2025-05-21 04:39:00', 'CJAMS-59770', '2025-05-21 04:39:00', 1, false, 'VAVU', 'VAFF', 'V5MF', NULL, NULL, NULL, 'CCCN', 'CFFN', 'C5MF',NULL , NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'CPSRTSV', '303f7300-613a-488a-bea0-d7fd382ab705', '362790f2-6f25-4f90-b29a-157006b2c41f', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d', 'CWCW', 'CWSP', (select cpsresponsetimeractionsid from cpsresponsetimeractions where updatedby  = 'CJAMS-59770'), 15, 0, '303f7300-613a-488a-bea0-d7fd382ab705', '2025-05-21 04:39:00', 'CJAMS-59770', '2025-05-21 04:39:00', true, 'CPS Response Timer Save Request to Supervisor', NULL, 'CPS Response Timer Save Request to Supervisor', '251023000800', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'CPSRTSV', '362790f2-6f25-4f90-b29a-157006b2c41f', '303f7300-613a-488a-bea0-d7fd382ab705', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d', 'CWCW', 'CWSP', (select cpsresponsetimeractionsid from cpsresponsetimeractions where updatedby  = 'CJAMS-59770'), 16, 1, '362790f2-6f25-4f90-b29a-157006b2c41f', '2025-05-21 04:39:00', 'CJAMS-59770', '2025-05-21 04:39:00', true, 'CPS Response Timer Save Request to Supervisor', NULL, 'CPS Response Timer Save Request to Supervisor', '251023000800', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

