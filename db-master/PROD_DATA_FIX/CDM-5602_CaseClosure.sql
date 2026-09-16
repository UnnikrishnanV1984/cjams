--CDM-5602 - Added record in routing for approval of case

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'd935b057-d7dc-4125-90bf-16f6a51e7ab5', NULL, NULL, NULL, NULL, '31ffc994-670a-41e6-9564-29f0ed677058', 16, 1, 'd935b057-d7dc-4125-90bf-16f6a51e7ab5', '2020-10-05 00:00:00', 'CDM-5602', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
