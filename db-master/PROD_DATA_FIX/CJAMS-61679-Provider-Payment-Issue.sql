/*
    CJAMS-61679
    Issue: This placement should be voided as there was an issue with entry and the provider has not been paid. 
    Root cause:User requested to delete review provider placement
    Resolution: provided a data fix to remove placement. which was done as a part of CJAMS-61679-remove-placement-review.sql but the associated payment was missed on that fix.
*/
-- Previous placement removal PR: https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/16012/overview
-- reverting back previous fix placement, routing, placement revision.
update placement set activeflag = 1, updatedby = 'CJAMS-61679',
altproviderid ='5085064',
updatedon = now() 
where placementid='fe380a14-a7e5-433f-aae0-fac780acd7c3' and activeflag =0; 

/*
-- second routing
select activeflag ,updatedby ,routingstatustypeid ,* from routing where objectid='fe380a14-a7e5-433f-aae0-fac780acd7c3' 
order by insertedon ;
*/

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('efa20ef2-b93a-48e6-b8ab-37f132576414'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWCW', 'CWSP', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 15, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:00:04.835', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:02:42.203', true, '', NULL, 'Placement Exit Submitted for review', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('722743de-03c6-49a0-b20e-358119fdb2d2'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWCW', 'CWSP', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 15, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:02:42.203', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:05:29.894', true, '', NULL, 'Provider placement submitted for review', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('7a5ade5c-2800-4dbd-8a06-e92d4b0ca984'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWSP', 'CWSP', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 17, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:05:29.894', 'CJAMS-61679', '2025-09-02 22:39:54.552', true, 'incorrect placement entry', NULL, 'Child PlacementRejected', '241030359333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3bc93db7-a5d5-4839-880f-f13fbae274ae'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWCW', 'CWSP', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 15, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:06.008', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:24.808', true, '', NULL, 'Provider placement submitted for review', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('ab8d392e-946c-4817-aa61-ae019b4b17ff'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWSP', 'CWCW', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:24.808', 'CJAMS-61679', '2025-09-02 22:39:54.552', true, '', NULL, 'Child PlacementApproved', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('79285af9-c168-42b0-91f5-60e5a9149d09'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', NULL, NULL, 'CWSP', 'IVESV', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:24.808', 'CJAMS-61679', '2025-09-02 22:39:54.552', false, NULL, NULL, NULL, '241030359333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('10413efc-ee37-45f7-87d4-d942a488ac0c'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWSP', 'CWCW', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:27.962', 'CJAMS-61679', '2025-09-02 22:39:54.552', true, '', NULL, 'Child PlacementApproved', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5f9c11db-9fb1-4a11-b882-9ecbf13fbd1e'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', NULL, NULL, 'CWSP', 'IVESV', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:27.962', 'CJAMS-61679', '2025-09-02 22:39:54.552', false, NULL, NULL, NULL, '241030359333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('dc4db9b6-64c4-4bd5-9fe7-63fd2d651398'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', NULL, NULL, 'CWSP', 'IVESV', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'CJAMS-61679', '2025-09-02 22:39:54.552', false, NULL, NULL, NULL, '241030359333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('bdbb9d49-0d02-4fb2-aa26-b8f76cfeab15'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWSP', 'CWCW', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'CJAMS-61679', '2025-09-02 22:39:54.552', true, '', NULL, 'Child PlacementApproved', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('926f776e-b5c8-4533-9644-0fcfe7e697e0'::uuid, 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'f701408a-e888-4f22-97e5-3cc6363df239'::uuid, 'CWCW', 'CWSP', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 15, 0, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:03:19.216', 'CJAMS-61679', '2025-09-02 22:39:54.552', true, '', NULL, 'Placement Exit Submitted for review', '241030359333', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='efa20ef2-b93a-48e6-b8ab-37f132576414'::uuid;
DELETE FROM cjams.routing
WHERE routingid='722743de-03c6-49a0-b20e-358119fdb2d2'::uuid;
DELETE FROM cjams.routing
WHERE routingid='7a5ade5c-2800-4dbd-8a06-e92d4b0ca984'::uuid;
DELETE FROM cjams.routing
WHERE routingid='3bc93db7-a5d5-4839-880f-f13fbae274ae'::uuid;
DELETE FROM cjams.routing
WHERE routingid='ab8d392e-946c-4817-aa61-ae019b4b17ff'::uuid;
DELETE FROM cjams.routing
WHERE routingid='79285af9-c168-42b0-91f5-60e5a9149d09'::uuid;
DELETE FROM cjams.routing
WHERE routingid='10413efc-ee37-45f7-87d4-d942a488ac0c'::uuid;
DELETE FROM cjams.routing
WHERE routingid='5f9c11db-9fb1-4a11-b882-9ecbf13fbd1e'::uuid;
DELETE FROM cjams.routing
WHERE routingid='dc4db9b6-64c4-4bd5-9fe7-63fd2d651398'::uuid;
DELETE FROM cjams.routing
WHERE routingid='bdbb9d49-0d02-4fb2-aa26-b8f76cfeab15'::uuid;
DELETE FROM cjams.routing
WHERE routingid='926f776e-b5c8-4533-9644-0fcfe7e697e0'::uuid;

-- a0696137-ffef-4e9c-ace2-d3c856a23902 with routingstatus 15 so no need to update that routing record
update routing 
set updatedby = 'CJAMS-61679', updatedon = now(), activeflag = 1
where objectid='fe380a14-a7e5-433f-aae0-fac780acd7c3' 
	and routingid in('4b64e4dd-5e39-4f6c-b23e-0c3bc1b40ab3',
		'79584928-41d9-4303-af20-23cfeb23039c');

/*
-- placement revision
-- 1b4bdd15-c932-42a9-9919-5345dbcdd3fd  8865bc87-5549-4771-9f6c-b91ef3d25026 ---> retain
select * from placementrevision 
where 	
 placementid = 'fe380a14-a7e5-433f-aae0-fac780acd7c3' order by insertedon ;
*/

/*
 * no need to update with active flag
update placementrevision set activeflag = 1, updatedby = 'CJAMS-61679', updatedon = now() 
where placementrevisionid in ('1b4bdd15-c932-42a9-9919-5345dbcdd3fd','8865bc87-5549-4771-9f6c-b91ef3d25026')
and placementid ='fe380a14-a7e5-433f-aae0-fac780acd7c3';
*/

/*
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('19c5b9bb-66c2-4651-b997-ca6c16a8ff8b'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', '2025-07-16 00:00:00.000', '16:31', NULL, NULL, '', '3045', '2025-08-19 00:00:00.000', '1', '2025-08-18 09:00:05.337', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2483375, NULL, NULL, NULL, NULL, 'CIPS', 'Incorrect placement entry. ', 0, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:00:05.337', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('f990e22b-7776-46f7-8f56-678c151ba108'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', NULL, '16:31', NULL, NULL, '', '3045', '2025-08-19 00:00:00.000', '1', '2025-08-18 09:02:42.687', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2483376, NULL, NULL, NULL, NULL, NULL, 'Incorrect placement entry. ', 0, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:02:42.687', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:05:29.894', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('0d45a539-c85c-4ad9-b438-0fa7d09d75b0'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', NULL, '16:31', NULL, NULL, '', '3281', '2025-08-19 00:00:00.000', '1', '2025-08-18 09:05:29.894', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2483377, NULL, NULL, NULL, NULL, NULL, 'Incorrect placement entry. ', 0, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:02:42.687', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-18 09:05:29.894', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('3a375b89-b5fb-43ce-82d7-d95089180c17'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', NULL, '16:31', NULL, NULL, '', '3045', '2025-08-19 00:00:00.000', '1', '2025-08-19 14:02:06.506', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2484893, NULL, NULL, NULL, NULL, NULL, 'Incorrect placement entry. ', 0, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:06.506', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:24.808', NULL, NULL, NULL, NULL, 'Approved', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('20276355-49f5-4133-b61b-8f7eb4614d4c'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', NULL, '16:31', NULL, NULL, '', '3047', '2025-08-19 00:00:00.000', '1', '2025-08-19 14:02:24.808', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2484894, NULL, NULL, NULL, NULL, NULL, 'Incorrect placement entry. ', 0, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:06.506', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:24.808', NULL, NULL, NULL, NULL, 'Approved', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('d10c7923-e60f-4735-a318-99ed829ff3f8'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', NULL, '16:31', NULL, NULL, '', '3047', '2025-08-19 00:00:00.000', '1', '2025-08-19 14:02:27.962', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2484895, NULL, NULL, NULL, NULL, NULL, 'Incorrect placement entry. ', 0, NULL, NULL, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:27.962', NULL, NULL, NULL, NULL, 'Approved', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('20180054-ea71-44ae-924f-e1868f552286'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', NULL, '16:31', NULL, NULL, '', '3047', '2025-08-19 00:00:00.000', '1', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 0, 2484896, NULL, NULL, NULL, NULL, NULL, 'Incorrect placement entry. ', 0, NULL, NULL, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:02:32.838', NULL, NULL, NULL, NULL, 'Approved', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('ca082d29-954f-49d7-8540-5f0840f29ec0'::uuid, 'fe380a14-a7e5-433f-aae0-fac780acd7c3'::uuid, '2025-08-19 00:00:00.000', '2025-07-16 00:00:00.000', '16:30', '2025-07-16 00:00:00.000', '16:31', NULL, NULL, '', '3045', NULL, '1', '2025-08-19 14:03:19.717', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-09-02 22:39:54.552', 'CJAMS-61679', 0, 2484897, NULL, NULL, NULL, NULL, 'CIPS', NULL, 0, NULL, 'fa6c7906-97af-4f35-8987-dbc6add7090d', '2025-08-19 14:03:19.717', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'Child was taken from kinship placement due to extensive safety concerns, Child needed a placement ASAP. Department in working on other possible kinship placements.', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
	
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='19c5b9bb-66c2-4651-b997-ca6c16a8ff8b'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='f990e22b-7776-46f7-8f56-678c151ba108'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='0d45a539-c85c-4ad9-b438-0fa7d09d75b0'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='3a375b89-b5fb-43ce-82d7-d95089180c17'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='20276355-49f5-4133-b61b-8f7eb4614d4c'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='d10c7923-e60f-4735-a318-99ed829ff3f8'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='20180054-ea71-44ae-924f-e1868f552286'::uuid;
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='ca082d29-954f-49d7-8540-5f0840f29ec0'::uuid;


INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
	exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), 'fe380a14-a7e5-433f-aae0-fac780acd7c3', current_date, '2025-07-16 00:00:00.000', '16:30', 
	'2025-07-16 00:00:00.000', '16:31', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CJAMS-61679', 
	now(), 'CJAMS-61679', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '7b3f4b50-6b3c-4bee-8292-c70c31c68db5', now(), 'fa6c7906-97af-4f35-8987-dbc6add7090d', 
	now(), NULL, NULL, NULL, 'Approved'
);

/*
7b3f4b50-6b3c-4bee-8292-c70c31c68db5-- Micaiah Baker
fa6c7906-97af-4f35-8987-dbc6add7090d -- Monique Swain SUP
select * from userprofile u where securityusersid = 'fa6c7906-97af-4f35-8987-dbc6add7090d';
*/

INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
	exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), 'fe380a14-a7e5-433f-aae0-fac780acd7c3', current_date, '2025-07-16 00:00:00.000', '16:30', 
	'2025-07-16 00:00:00.000', '16:31', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CJAMS-61679', 
	now(), 'CJAMS-61679', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '7b3f4b50-6b3c-4bee-8292-c70c31c68db5', now(), 'fa6c7906-97af-4f35-8987-dbc6add7090d', 
	now(), NULL, NULL, NULL, 'Approved'
);


-- placement update
update placement 
set isvoided = 1, 
	voidapprovaldate = current_date, 
	voidapprovalstatustypekey = '3047', 
	voiddate = current_date, 
	enddatetime = current_date,
	voidreasontypekey = 'WKER',
	updatedby = 'CJAMS-61679', 
	updatedon = now()
where placementid = 'fe380a14-a7e5-433f-aae0-fac780acd7c3' 
	and activeflag = 1 ;


-- rounting
-- select activeflag ,updatedby ,* from routing where objectid='fe380a14-a7e5-433f-aae0-fac780acd7c3' 
-- order by insertedon ;

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid,
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', '7b3f4b50-6b3c-4bee-8292-c70c31c68db5', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 
		'f701408a-e888-4f22-97e5-3cc6363df239', 'CWCW', 'CWSP', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 15, 0, 
		'CJAMS-61679', now(), 'CJAMS-61679', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '241030359333', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', '7b3f4b50-6b3c-4bee-8292-c70c31c68db5', 
		'f701408a-e888-4f22-97e5-3cc6363df239', 'CWSP', 'CWCW', 'fe380a14-a7e5-433f-aae0-fac780acd7c3', 16, 1, 
		'CJAMS-61679', now(), 'CJAMS-61679', now(), true, 
		'', NULL, 'Child Placement Void Approved', '241030359333', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);
	

-- change to delet switch Y as there is pending validation
--select delete_sw ,* from tb_placement_validation tpv where placement_id = '2114762';

update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-61679'
where placement_id = '2114762'
	and delete_sw = 'N' ; 

--SELECT cjams.sp_under_over_pub(current_date);