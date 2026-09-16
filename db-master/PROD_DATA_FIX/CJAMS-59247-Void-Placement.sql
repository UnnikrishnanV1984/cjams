/*
Issue Description: Please proceed with the data fix to remove the rejected placement so the correct placement can be entered. 
As per system design, the rejected placement can be edited but not able to changed the placement structure & program name.
Client ID# : 3908431 (HOPE JOAN TOKARSKI)
Category/Module: Support
Root cause: Application does not allow entire placement records to be deleted.As per system design, the rejected placement can be edited 
but not able to changed the placement structure & program name.
Fix provided: DB queries to deactivate rejected placement to prevent overlap
Data/Code fix ticket#: CJAMS-59247
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='2619f028-a07f-485a-817f-c6d03eb65992';
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='38c4c05e-71fe-4430-9629-257ca222cc16';
DELETE FROM cjams.placementrevision
WHERE placementrevisionid='54ad854c-2bc3-465b-82df-8d31a4c19817';

/*
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('2619f028-a07f-485a-817f-c6d03eb65992', '0b145fba-4de0-4e43-aa3f-61cd277b219c', '2025-04-24 00:00:00.000', '2024-12-04 00:00:00.000', '09:01', NULL, '08:30', NULL, NULL, '', '3281', '2025-04-24 00:00:00.000', '1', '2025-04-24 10:12:49.023', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:52.608', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', 0, 2412256, NULL, NULL, NULL, NULL, 'CIPS', 'Issue with coding of placement. ', 0, NULL, 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', '2025-04-24 08:54:56.819', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:49.023', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Less intensive environment that still meets child''s therapeutic needs to work towards lower level of care. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('38c4c05e-71fe-4430-9629-257ca222cc16', '0b145fba-4de0-4e43-aa3f-61cd277b219c', '2025-04-24 00:00:00.000', '2024-12-04 00:00:00.000', '09:01', '2025-04-24 00:00:00.000', '08:30', NULL, NULL, '', '3045', NULL, '1', '2025-04-24 08:54:56.819', 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', '2025-04-24 10:12:52.608', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', 0, 2412110, NULL, NULL, NULL, NULL, 'CIPS', 'Issue with coding of placement. ', 0, NULL, 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', '2025-04-24 08:54:56.819', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:49.023', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Less intensive environment that still meets child''s therapeutic needs to work towards lower level of care. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency, placementluggage, plluggagepurchased, plluggagecomments, objectid, objecttype, placementdisposableortrashbag, exitluggage, exitluggageprovided, exitluggagecomments, exitdisposableortrashbag)
VALUES('54ad854c-2bc3-465b-82df-8d31a4c19817', '0b145fba-4de0-4e43-aa3f-61cd277b219c', NULL, '2024-12-04 00:00:00.000', '09:01', NULL, '08:30', NULL, NULL, '', '3281', '2025-04-24 00:00:00.000', '1', '2025-04-24 10:12:52.608', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:52.608', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', 1, 2412257, NULL, NULL, NULL, NULL, 'CIPS', 'Issue with coding of placement. ', 0, NULL, NULL, NULL, 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:52.608', NULL, NULL, NULL, NULL, 'Rejected', NULL, 'Less intensive environment that still meets child''s therapeutic needs to work towards lower level of care. ', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='11b46d82-4acd-41ab-bc5e-6523d5e79224';
DELETE FROM cjams.routing
WHERE routingid='31a25804-1413-4f27-82e2-77c51c30daee';
DELETE FROM cjams.routing
WHERE routingid='50ca9d0a-f99a-4589-a2ba-b718f71b604a';

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('11b46d82-4acd-41ab-bc5e-6523d5e79224', 'PLTR', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', '091dfa7d-f371-40b6-8394-55984c940ad2', 'CWSP', 'CWCW', '0b145fba-4de0-4e43-aa3f-61cd277b219c', 17, 1, 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:49.023', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:49.023', true, 'need to void', NULL, 'Child PlacementRejected', '3301857', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('31a25804-1413-4f27-82e2-77c51c30daee', 'PLTR', 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '091dfa7d-f371-40b6-8394-55984c940ad2', 'CWCW', 'CWSP', '0b145fba-4de0-4e43-aa3f-61cd277b219c', 15, 0, 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', '2025-04-24 08:54:56.302', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:49.023', true, '', NULL, 'Placement Exit Submitted for review', '3301857', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('50ca9d0a-f99a-4589-a2ba-b718f71b604a', 'PLTR', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', 'b7bd9c21-48bc-4679-9346-6fb2a5854a11', '091dfa7d-f371-40b6-8394-55984c940ad2', 'CWSP', 'CWCW', '0b145fba-4de0-4e43-aa3f-61cd277b219c', 17, 1, 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:52.608', 'ffaff6c5-0784-47e8-b29e-a04373e6cc89', '2025-04-24 10:12:52.608', true, 'need to void', NULL, 'Child PlacementRejected', '3301857', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/