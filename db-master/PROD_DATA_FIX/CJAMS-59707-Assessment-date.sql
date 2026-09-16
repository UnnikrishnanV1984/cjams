/*
   Issue Description: CJAMS-59707 - 3225131:I previously entered a ticket (S20250126066367) to get the CANS OOH assessments to populate the data when in the print function. All 4 of these assessments are showing the same date and time as the Date Time Assessment Initiated, 7/25/20 at 11:27am. These assessments were entered by 2 separate workers so there is no way to duplicate the assessment. Is this a glitch or is there a way to recapture the accurate assessment dates and times. This information is needed for a subpoena request that is time sensitive. 
   Category/ Module  :Assessments -CANS OOH
   Root cause: Issue caused after migration of data
   Fix Provided: Data fix has been done by updating the old dates for each of the cans ooh assessment
   Data/Code fix ticket#: CJAMS-59707
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: 
*/
/*
CJAMS data 
insertedon                updatedon                assessmentid
2015-01-22 10:27:54.000    2025-05-16 18:19:45.388    5e05fddf-10a1-4b61-92b1-a61609d4996c
2015-07-20 10:11:52.000    2025-05-16 18:19:45.388    3884fd9c-205b-4bd4-8aae-bc1496fe0f8f
2016-02-29 11:26:09.000    2025-05-16 18:19:45.388    3d8064dd-2efe-4033-bd33-8c88e5eb9da8
2016-05-10 14:32:21.000    2025-05-16 18:19:45.388    01ab4200-2baa-4f09-8d64-b0b80bf5553f

Legacy Data 
create_ts                update_ts                assessment_dt    cans_assessment_id
2015-01-22 10:27:54.000    2015-01-22 15:09:40.000    2015-01-22        16569
2015-07-20 10:11:52.000    2015-07-20 10:23:33.000    2015-07-20        19062
2016-02-29 11:26:09.000    2016-02-29 11:33:51.000    2016-01-20        23992
2016-05-10 14:32:21.000    2016-05-10 14:43:02.000    2016-05-09        25289
*/


update assessment 
set updatedon = '2015-01-22 15:09:40.000', updatedby='migration',
submissiondata = jsonb_set(
                         jsonb_set(
                             submissiondata,
                             '{faceLifeForm,dateassessmentinitiated}',
                             to_jsonb('01/22/2015 10:27:54.000'::text)
                         ),
                         '{authorizationForm,safetyassessmentapprovaldate}',
                         to_jsonb('01/22/2015 15:09:40.000'::text)
                     )
where assessmentid = '5e05fddf-10a1-4b61-92b1-a61609d4996c'
and activeflag =1;

update routing 
set	insertedon = '2015-01-22 15:09:40.000',
	updatedby = 'CJAMS-59707',--admin
	updatedon = now()
where routingid = '1689df9d-5237-4ca6-ba12-c26abd4c579a' 
and activeflag =1;

DELETE FROM cjams.routing
WHERE routingid in ('abd3e299-7177-4673-9fa0-9c700d6274fb',
'480abdfb-a35a-40b6-bce3-4f9cd0395f47',
'71da0ebb-972f-407d-b0b8-55e89783b948');


/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1689df9d-5237-4ca6-ba12-c26abd4c579a'::uuid, 'ASST', '729fe1eb-abea-4745-a6da-f88cb690f7a8', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '5e05fddf-10a1-4b61-92b1-a61609d4996c', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('abd3e299-7177-4673-9fa0-9c700d6274fb'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '5e05fddf-10a1-4b61-92b1-a61609d4996c', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('480abdfb-a35a-40b6-bce3-4f9cd0395f47'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '5e05fddf-10a1-4b61-92b1-a61609d4996c', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('71da0ebb-972f-407d-b0b8-55e89783b948'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '5e05fddf-10a1-4b61-92b1-a61609d4996c', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/



-- 3884fd9c-205b-4bd4-8aae-bc1496fe0f8f
update assessment 
set updatedon = '2015-07-20 10:23:33.000', updatedby='migration',
submissiondata = jsonb_set(
                         jsonb_set(
                             submissiondata,
                             '{faceLifeForm,dateassessmentinitiated}',
                             to_jsonb('07/20/2015 10:11:52.000'::text)
                         ),
                         '{authorizationForm,safetyassessmentapprovaldate}',
                         to_jsonb('2015-07-20 10:23:33.000'::text)
                     )
where assessmentid = '3884fd9c-205b-4bd4-8aae-bc1496fe0f8f'
and activeflag =1;

update routing 
set	insertedon = '2015-07-20 10:23:33.000',
	updatedby = 'CJAMS-59707',--admin
	updatedon = now()
where routingid = '942fd89e-8a3a-4644-bd44-85708edd6cfd' --
and activeflag =1;

DELETE FROM cjams.routing
WHERE routingid in ('97605926-43e3-41ae-abdf-4f167c5fd13a',
'601c1e13-bb1d-45bf-9fe6-a06eda1b09d0',
'40200571-3b21-45f0-8368-d1176c1053d8');



/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('942fd89e-8a3a-4644-bd44-85708edd6cfd'::uuid, 'ASST', '729fe1eb-abea-4745-a6da-f88cb690f7a8', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3884fd9c-205b-4bd4-8aae-bc1496fe0f8f', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('97605926-43e3-41ae-abdf-4f167c5fd13a'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3884fd9c-205b-4bd4-8aae-bc1496fe0f8f', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('601c1e13-bb1d-45bf-9fe6-a06eda1b09d0'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3884fd9c-205b-4bd4-8aae-bc1496fe0f8f', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('40200571-3b21-45f0-8368-d1176c1053d8'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3884fd9c-205b-4bd4-8aae-bc1496fe0f8f', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

--3d8064dd-2efe-4033-bd33-8c88e5eb9da8
update assessment 
set updatedon = '2016-02-29 11:33:51.000', updatedby='migration',
submissiondata = jsonb_set(
                         jsonb_set(
                             submissiondata,
                             '{faceLifeForm,dateassessmentinitiated}',
                             to_jsonb('02/29/2016 11:26:09.000'::text)
                         ),
                         '{authorizationForm,safetyassessmentapprovaldate}',
                         to_jsonb('02/29/2016 11:33:51.000'::text)
                     )
where assessmentid = '3d8064dd-2efe-4033-bd33-8c88e5eb9da8'
and activeflag =1;
--routing: 2016-02-29 11:33:51.000
update routing 
set	insertedon = '2016-02-29 11:33:51.000',
	updatedby = 'CJAMS-59707',--admin
	updatedon = now()
where routingid = '6a25acb2-0afd-43c5-bd16-2cb2b5b51812' --
and activeflag =1;

DELETE FROM cjams.routing
WHERE routingid in ('b1ec68ca-7ed9-4b05-b73c-f94c60dd9ebf',
'a3a4f024-f6df-4014-b89b-56c3f3dfe4e8',
'1957805f-83eb-4a0c-99e0-a985ebea4945');

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6a25acb2-0afd-43c5-bd16-2cb2b5b51812'::uuid, 'ASST', '729fe1eb-abea-4745-a6da-f88cb690f7a8', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3d8064dd-2efe-4033-bd33-8c88e5eb9da8', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b1ec68ca-7ed9-4b05-b73c-f94c60dd9ebf'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3d8064dd-2efe-4033-bd33-8c88e5eb9da8', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a3a4f024-f6df-4014-b89b-56c3f3dfe4e8'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3d8064dd-2efe-4033-bd33-8c88e5eb9da8', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1957805f-83eb-4a0c-99e0-a985ebea4945'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '3d8064dd-2efe-4033-bd33-8c88e5eb9da8', 16, 1, 'admin', '2020-07-25 11:27:12.525', 'admin', '2020-07-25 11:27:12.525', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/


--01ab4200-2baa-4f09-8d64-b0b80bf5553f
update assessment 
set updatedon = '2016-05-10 14:43:02.000', updatedby='migration',
	submissiondata = jsonb_set(
                         jsonb_set(
                             submissiondata,
                             '{faceLifeForm,dateassessmentinitiated}',
                             to_jsonb('05/10/2016 14:32:21.000'::text)
                         ),
                         '{authorizationForm,safetyassessmentapprovaldate}',
                         to_jsonb('05/10/2016 14:43:02.000'::text)
                     )
where assessmentid = '01ab4200-2baa-4f09-8d64-b0b80bf5553f'
and activeflag =1;


-- removing duplicate routing

update routing 
set	insertedon = '2016-05-10 14:43:02.000',--2020-07-25 11:27:12.525
	updatedby = 'CJAMS-59707',--admin
	updatedon = now()
where routingid = '5625d91c-1286-4604-adab-5995adfcb1dd' 
and activeflag =1;

/*
 * removed the duplicate records inserted during the data migration

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5625d91c-1286-4604-adab-5995adfcb1dd'::uuid, 'ASST', '729fe1eb-abea-4745-a6da-f88cb690f7a8', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '01ab4200-2baa-4f09-8d64-b0b80bf5553f', 16, 1, 'admin', '2016-05-10 14:43:02.000', 'CJAMS-59707', '2025-06-06 14:18:46.073', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0b2b6365-8c1d-4db0-90d2-895e9d24c795'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '01ab4200-2baa-4f09-8d64-b0b80bf5553f', 16, 0, 'admin', '2020-07-25 11:27:12.525', 'CJAMS-59707', '2025-06-06 14:18:50.047', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4891122a-4257-4f78-b8a2-b34313b8e859'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '01ab4200-2baa-4f09-8d64-b0b80bf5553f', 16, 0, 'admin', '2020-07-25 11:27:12.525', 'CJAMS-59707', '2025-06-06 14:18:50.047', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('ecae86f2-8cce-4b9e-8bfa-1603e5947f0c'::uuid, 'ASST', 'b628a3f7-827d-41c9-ac25-6445fce42838', '1d8e0768-c948-475d-9247-e5eae83b45fb', '5b277f4b-30df-493e-b44c-2ea6fd9e7c3d'::uuid, 'CWSP', 'CWCW', '01ab4200-2baa-4f09-8d64-b0b80bf5553f', 16, 0, 'admin', '2020-07-25 11:27:12.525', 'CJAMS-59707', '2025-06-06 14:18:50.047', false, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid in ('0b2b6365-8c1d-4db0-90d2-895e9d24c795',
'4891122a-4257-4f78-b8a2-b34313b8e859',
'ecae86f2-8cce-4b9e-8bfa-1603e5947f0c');