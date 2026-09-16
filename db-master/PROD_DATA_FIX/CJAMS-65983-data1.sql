/*
Issue:Change in placement struture
Root Cause: user wants to change exit type so updating the exit type and keeping the placement in review so supervisor can approve the placement
Fix Provided (Data Fix Only):Data fix was done to  update the exit type and keeping the placement in review so supervisor can approve the placement
Data/Code fix ticket#: CJAMS-65983
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



/*
 INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('6a9c5465-d828-4db1-96a0-7ca59b8570f9'::uuid, '8d2cb68d-e245-408d-b0ae-ff79a786339e'::uuid, '2026-02-25 00:00:00.000', '2025-06-23 00:00:00.000', '11:01', NULL, NULL, NULL, 'GUARDR', '', '3281', '2026-03-17 00:00:00.000', '1', '2026-03-17 08:14:30.031', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-03-18 10:51:59.154', 'CJAMS-65983', 1, 2769008, NULL, NULL, NULL, NULL, 'PLCC', 'Custody and Guardianship of Ka''mani Rhodeshas been granted to Maternal Grandmother Eva Cruz through an approved kinship home study and Guardianship Assistance Program. ', 0, NULL, '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '2026-02-25 09:53:36.235', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-03-17 08:14:30.031', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Ka''mani is being placed with his maternal grandmother Ms. Cruz through an approved Kinship Home study. This is the least restrictive placement as there is no other kin, fictive kin, or chosen family resource available for Jaydan at this time. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.placementrevision
WHERE placementrevisionid='6a9c5465-d828-4db1-96a0-7ca59b8570f9'::uuid;

update placementrevision set activeflag = 1,exitreasontypkey =null,exittypekey ='CIPS',
updatedby ='CJAMS-65983',updatedon =now()
where placementrevisionid ='70b8a908-399a-45ae-97d5-dad497c5faed';
/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1536f4ad-2920-47a2-bd66-696ea12f2324'::uuid, 'PLTR', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '9ba627aa-47a3-4059-8bea-6fe500d2c14c', '96e4a285-8f90-47a8-a589-419d5bdd291b'::uuid, 'CWSP', 'CWCW', '8d2cb68d-e245-408d-b0ae-ff79a786339e', 17, 1, 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-03-17 08:14:30.031', 'abe58d96-d2ec-40b3-b2f1-981baab01af9', '2026-03-17 08:14:30.031', true, 'Change Exit Type', NULL, 'Child PlacementRejected', '2020032404314', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='1536f4ad-2920-47a2-bd66-696ea12f2324'::uuid;

update routing set activeflag =1,
updatedby ='CJAMS-65983',updatedon =now()
where routingid ='4c45541b-564d-4b75-80a5-443cef24a0b9';