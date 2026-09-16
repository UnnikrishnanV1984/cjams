/*
Issue Description: CJAMS-58583::The MFIRA assessment for case #251030464919 was approved by the supervisor on 02/21/2025 at 2:04:16 AM, but the fields under "Assignment Submission Date Time" and "UPDATED DATE AND TIME" are blank
Category/Module: Assessment/MFIRA
Root cause: There is an issue in the assessment flow and supervisor who has created the review request is able to approve the assessment.
            This is causing issue with insertion of records in the routing table and some records are missing from the form.
Fix provided: Data fix has been done to insert the assesment date and approval information in routing table.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: YTD
Reason why no related code fix: N/A
*/


UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{authorizationApproval, safetyassessmentapprovaldate}', '"2025-02-21T02:04:16"')
where assessmentid = '60fd7b11-f856-4fdf-b644-9a2741263441';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'ASST', '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f', '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f', '44a936b9-8a02-4136-ae62-06009f9e50db'::uuid, 'CWCW', 'CWSP', '60fd7b11-f856-4fdf-b644-9a2741263441', 15, 0, '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f', '2025-02-21 01:39:02.668', 'CJAMS-58583', now(), true, '', NULL, '', '251030464919', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'ASST', '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f', '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f', '44a936b9-8a02-4136-ae62-06009f9e50db'::uuid, 'CWSP', 'CWCW', '60fd7b11-f856-4fdf-b644-9a2741263441', 16, 1, '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f', '2025-02-21 02:04:16.668', 'CJAMS-58583', now(), true, '', NULL, '', '251030464919', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);