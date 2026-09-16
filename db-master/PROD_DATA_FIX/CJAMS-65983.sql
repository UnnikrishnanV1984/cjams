/*
Issue Description:CJAMS-65983
Category/Module: Placement 
Root cause: User requested to end the date of the placement and modify the status
Fix provided: Data fix has been done to hard delete the placements and make the latest record active, so user can proceed with the approval
Data/Code fix ticket#: CJAMS-65983
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User ended placement incorrectly and data fix needed to remove the enddate.
*/


/*

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('f09d98e6-4e8f-46b2-b65a-4d98eca721ad', '8d2cb68d-e245-408d-b0ae-ff79a786339e', '2026-02-27 00:00:00.000', '2025-06-23 00:00:00.000', '11:01', '2026-02-24 00:00:00.000', NULL, NULL, 'GUARDR', '', '3281', '2026-02-27 00:00:00.000', '1', '2026-02-27 14:17:01.270', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-03-13 12:49:29.007', 'CJAMS-65983', 1, 2745515, NULL, NULL, NULL, NULL, NULL, 'Custody and Guardianship of Ka''mani Rhodeshas been granted to Maternal Grandmother Eva Cruz through an approved kinship home study and Guardianship Assistance Program. ', 0, NULL, '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '2026-02-27 14:13:39.286', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', NULL, NULL, NULL, NULL, 'Approved', NULL, 'Ka''mani is being placed with his maternal grandmother Ms. Cruz through an approved Kinship Home study. This is the least restrictive placement as there is no other kin, fictive kin, or chosen family resource available for Jaydan at this time. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('77e094d6-8ccc-4eae-b46d-5a04f90f8dd3', '8d2cb68d-e245-408d-b0ae-ff79a786339e', '2026-02-27 00:00:00.000', '2025-06-23 00:00:00.000', '11:01', NULL, NULL, NULL, 'GUARDR', '', '3045', NULL, '1', '2026-02-27 14:13:39.286', '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '2026-02-27 14:17:01.270', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', 0, 2745510, NULL, NULL, NULL, NULL, NULL, 'Custody and Guardianship of Ka''mani Rhodeshas been granted to Maternal Grandmother Eva Cruz through an approved kinship home study and Guardianship Assistance Program. ', 0, NULL, '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '2026-02-27 14:13:39.286', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Ka''mani is being placed with his maternal grandmother Ms. Cruz through an approved Kinship Home study. This is the least restrictive placement as there is no other kin, fictive kin, or chosen family resource available for Jaydan at this time. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('dc371317-e8db-41ba-8e0e-33c1378ee74b', '8d2cb68d-e245-408d-b0ae-ff79a786339e', '2026-02-27 00:00:00.000', '2025-06-23 00:00:00.000', '11:01', NULL, NULL, NULL, 'GUARDR', '', '3281', '2026-02-27 00:00:00.000', '1', '2026-02-25 14:45:06.569', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', 0, 2741446, NULL, NULL, NULL, NULL, 'PLCC', 'Custody and Guardianship of Ka''mani Rhodeshas been granted to Maternal Grandmother Eva Cruz through an approved kinship home study and Guardianship Assistance Program. ', 0, NULL, NULL, NULL, 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-25 14:45:06.569', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Ka''mani is being placed with his maternal grandmother Ms. Cruz through an approved Kinship Home study. This is the least restrictive placement as there is no other kin, fictive kin, or chosen family resource available for Jaydan at this time. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('639ea3b6-a078-4ee1-a20d-fc1d00376fe1', '8d2cb68d-e245-408d-b0ae-ff79a786339e', '2026-02-27 00:00:00.000', '2025-06-23 00:00:00.000', '11:01', NULL, NULL, NULL, 'GUARDR', '', '3281', '2026-02-27 00:00:00.000', '1', '2026-02-25 14:45:03.453', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', 0, 2741445, NULL, NULL, NULL, NULL, 'PLCC', 'Custody and Guardianship of Ka''mani Rhodeshas been granted to Maternal Grandmother Eva Cruz through an approved kinship home study and Guardianship Assistance Program. ', 0, NULL, '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '2026-02-25 09:53:36.235', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-25 14:45:03.453', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Ka''mani is being placed with his maternal grandmother Ms. Cruz through an approved Kinship Home study. This is the least restrictive placement as there is no other kin, fictive kin, or chosen family resource available for Jaydan at this time. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('653f7b9c-dd9a-4507-aa98-6cf581c55a4c', 'PLTR', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '96e4a285-8f90-47a8-a589-419d5bdd291b', 'CWSP', 'CWCW', '8d2cb68d-e245-408d-b0ae-ff79a786339e', 17, 1, 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', true, 'Do not permanently exit care and custody', NULL, 'Child PlacementRejected', '2020032404314', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('416d8b2e-17d7-4981-8521-b3bc60598108', 'PLTR', '9ba627aa-47a3-4059-8bea-6fe500d2c14c', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '96e4a285-8f90-47a8-a589-419d5bdd291b', 'CWCW', 'CWSP', '8d2cb68d-e245-408d-b0ae-ff79a786339e', 15, 0, '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '2026-02-27 14:13:38.737', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-27 14:17:01.270', true, '', NULL, 'Provider placement submitted for review', '2020032404314', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('aa76e9ba-8eec-4e90-915d-5b7f49596199', 'PLTR', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '96e4a285-8f90-47a8-a589-419d5bdd291b', 'CWSP', 'CWSP', '8d2cb68d-e245-408d-b0ae-ff79a786339e', 17, 1, 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-25 14:45:06.569', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-25 14:45:06.569', true, 'Change the structure, do not do permanently leaving care and custody', NULL, 'Child PlacementRejected', '2020032404314', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('73784842-57e8-4bec-8382-1a9f75827bcd', 'PLTR', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '96e4a285-8f90-47a8-a589-419d5bdd291b', 'CWSP', 'CWCW', '8d2cb68d-e245-408d-b0ae-ff79a786339e', 17, 1, 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-25 14:45:03.453', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-02-25 14:45:03.453', true, 'Change the structure, do not do permanently leaving care and custody', NULL, 'Child PlacementRejected', '2020032404314', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='f09d98e6-4e8f-46b2-b65a-4d98eca721ad';

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='77e094d6-8ccc-4eae-b46d-5a04f90f8dd3';

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='dc371317-e8db-41ba-8e0e-33c1378ee74b';

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='639ea3b6-a078-4ee1-a20d-fc1d00376fe1';

DELETE FROM cjams.routing
WHERE routingid='653f7b9c-dd9a-4507-aa98-6cf581c55a4c';

DELETE FROM cjams.routing
WHERE routingid='416d8b2e-17d7-4981-8521-b3bc60598108';

DELETE FROM cjams.routing
WHERE routingid='aa76e9ba-8eec-4e90-915d-5b7f49596199';

DELETE FROM cjams.routing
WHERE routingid='73784842-57e8-4bec-8382-1a9f75827bcd';

update placementrevision set activeflag= 1,updatedby='CJAMS-65983',updatedon=now()
where placementrevisionid='70b8a908-399a-45ae-97d5-dad497c5faed';

update routing set activeflag=1,updatedby='CJAMS-65983',updatedon=now()
where routingid ='4c45541b-564d-4b75-80a5-443cef24a0b9';