/*
Issue: CJAMS-68663 Cannot break the link to create adoption record
Category/Module: Break the link
Root cause: rejected agreement record is created in the DB and this is not allowing to break the link.
This is a known issue as there is a subsidy agreement record without subsidy rate in DB.
Need data fix to remove the rejected subsidy agreement from DB so the break the link can be submitted for supervisor approval.
Case number 221030015881 and break the link can be done after removing the rejected subsidy agreement from DB.
Fix provided:  Data fix is done to delete rejected subsidy agreement for the case 221030015881
Data/Code fix ticket#: CJAMS-68663
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: BA/QA is trying to replicate this and then we will work on the code fix.
*/

update adoptionagreementrate
set adoptionagreementid='e091e3d9-84cc-48af-bfa1-92a823fbde35',
updatedby='CJAMS-68663',
updatedon=now()
where adoptionagreementrateid='f776d9d5-81bd-4a6c-b059-afb0d7ad1940' and activeflag=1;


update adoptionagreement
set activeflag=0,
updatedby='CJAMS-68663',
updatedon=now()
where  adoptionagreementid = '054bd47d-24d9-4ec6-a888-7535a2d31062' and activeflag = 1;


/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('84c8b557-a979-4ce8-85ab-1f13a3c79473', 'AARR', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW', 'CWSP', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 15, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-29 15:08:03.452', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0fe7062e-c319-4a3b-abbb-5a3fc47c32fd', 'AARR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWSP', 'CWCW', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 16, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-29 15:23:07.840', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Approved', NULL, 'Adoption Agreement Rate Approved', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b6ab93a3-7870-4396-905b-17d5b25a81e5', 'AARR', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW', 'CWSP', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 15, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-30 15:12:00.356', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('67ede117-84c8-4ef0-abab-68b00508f69a', 'AARR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWSP', 'CWCW', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 17, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-30 15:13:28.628', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Rejected', NULL, 'Adoption Agreement Rate Rejected', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3ad945f9-2544-4cc1-bd0c-25ae3d8f259e', 'AARR', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW', 'CWSP', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 15, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-30 15:16:13.428', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8f1c4d45-2be5-4cfc-b2d6-a877aba1acaa', 'AARR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWSP', 'CWCW', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 17, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-30 15:19:09.167', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Rejected', NULL, 'Adoption Agreement Rate Rejected', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('715514ad-4a14-4baa-a88e-19bf4cb788ee', 'AARR', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW', 'CWSP', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 15, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-30 15:26:31.672', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Submitted for Review', NULL, 'Adoption Agreement Rate Submitted for Review', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('eebf8e6b-2d30-481d-aa03-484c28073693', 'AARR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '94f06934-e3f2-43a7-bd06-22356c6f2e54', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWSP', 'CWCW', 'f776d9d5-81bd-4a6c-b059-afb0d7ad1940', 17, 0, '94f06934-e3f2-43a7-bd06-22356c6f2e54', '2026-06-30 15:27:31.496', 'CJAMS-68663', '2026-07-06 13:03:02.688', true, 'Adoption Agreement Rate Rejected', NULL, 'Adoption Agreement Rate Rejected', '221030015881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='84c8b557-a979-4ce8-85ab-1f13a3c79473';

DELETE FROM cjams.routing
WHERE routingid='0fe7062e-c319-4a3b-abbb-5a3fc47c32fd';

DELETE FROM cjams.routing
WHERE routingid='b6ab93a3-7870-4396-905b-17d5b25a81e5';

DELETE FROM cjams.routing
WHERE routingid='67ede117-84c8-4ef0-abab-68b00508f69a';

DELETE FROM cjams.routing
WHERE routingid='3ad945f9-2544-4cc1-bd0c-25ae3d8f259e';

DELETE FROM cjams.routing
WHERE routingid='8f1c4d45-2be5-4cfc-b2d6-a877aba1acaa';

DELETE FROM cjams.routing
WHERE routingid='715514ad-4a14-4baa-a88e-19bf4cb788ee';

DELETE FROM cjams.routing
WHERE routingid='eebf8e6b-2d30-481d-aa03-484c28073693';