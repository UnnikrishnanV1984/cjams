--  INSERT INTO cjams.placementrevision
--  (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
--  VALUES('e1402704-a032-42af-a917-6254856f5efe', 'cd741030-871b-4b5d-8b17-24abb39575e3', '2023-02-21 00:00:00.000', '2020-10-06 00:00:00.000', '10:00', '2023-01-23 00:00:00.000', NULL, NULL, NULL, '', '3045', '2023-02-21 00:00:00.000', '1', '2023-02-21 15:54:54.701', '65184bef-4775-4122-9bf0-45e2761b9292', '2023-02-21 15:54:54.701', '65184bef-4775-4122-9bf0-45e2761b9292', 0, 1264216, NULL, NULL, NULL, NULL, 'PLCC', 'CUSTODY AND GUARDIANSHIP WAS AWARDED TO SHAQUANTE BLACK ON 1-23-23 AND THE JURISDICTION OF THE COURT WAS TERMINATED.', 0, NULL, '65184bef-4775-4122-9bf0-45e2761b9292', '2023-02-21 15:54:54.701', NULL, NULL, NULL, NULL, NULL, NULL, 'Review', NULL, 'CHILD IS NO LONGER IN FOSTER CARE', NULL, NULL);

-- INSERT INTO cjams.placementrevision
-- (placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
-- VALUES('5c110890-4446-4ca0-b7c9-c91f8dd2d124', 'cd741030-871b-4b5d-8b17-24abb39575e3', '2023-02-21 00:00:00.000', '2020-10-06 00:00:00.000', '10:00', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2023-02-21 16:05:46.955', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-03-03 15:10:37.681', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 0, 1264351, NULL, NULL, NULL, NULL, NULL, 'CUSTODY AND GUARDIANSHIP WAS AWARDED TO SHAQUANTE BLACK ON 1-23-23 AND THE JURISDICTION OF THE COURT WAS TERMINATED.', 0, NULL, '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-02-21 16:05:46.955', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-03-03 15:10:37.681', NULL, NULL, NULL, NULL, 'Approved', NULL, 'CHILD IS NO LONGER IN FOSTER CARE', NULL, NULL);

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('478b7e5f-e6e7-4295-82ff-59eb89fa4ce8', 'PLTR', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '48602c12-8998-48d1-84e5-1aebbf761ceb', 'b50f2419-42ba-4ab6-84ab-5172917d2d77', 'LDSSSP', 'CWSP', 'cd741030-871b-4b5d-8b17-24abb39575e3', 15, 0, '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-02-21 16:05:46.474', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-03-03 15:07:07.193', true, '', NULL, 'Placement Exit Submitted for review', '3279102', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('0b1bb716-1040-4025-9606-0d58e4a692d1', 'PLTR', '65184bef-4775-4122-9bf0-45e2761b9292', '3ca8e63d-f885-445b-aab9-24456e91ad4a', 'b50f2419-42ba-4ab6-84ab-5172917d2d77', 'CWCW', 'LDSSSP', 'cd741030-871b-4b5d-8b17-24abb39575e3', 15, 0, '65184bef-4775-4122-9bf0-45e2761b9292', '2023-02-21 15:54:54.230', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '2023-03-03 15:18:40.555', true, '', NULL, 'Placement Exit Submitted for review', '3279102', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


---------------------------------------
DELETE FROM cjams.placementrevision
WHERE placementrevisionid in ('5c110890-4446-4ca0-b7c9-c91f8dd2d124');

UPDATE cjams.placementrevision
SET approvaldate=null, updatedon=now(), updatedby='CDM-28903', activeflag=1
WHERE placementrevisionid='e1402704-a032-42af-a917-6254856f5efe' and approvaldate is not null;

UPDATE cjams.routing
SET updatedon=now(), updatedby='CDM-28903', activeflag=1
WHERE routingid='0b1bb716-1040-4025-9606-0d58e4a692d1';

UPDATE cjams.routing
SET updatedon=now(), updatedby='CDM-28903', activeflag=0
WHERE routingid='478b7e5f-e6e7-4295-82ff-59eb89fa4ce8';


