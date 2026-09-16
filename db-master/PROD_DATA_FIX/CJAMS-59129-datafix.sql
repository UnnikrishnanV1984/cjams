/*
   Issue Description: CJAMS-59129
   Category/ Module  : Assignments
   Root cause: Requested to do the data fix to remove the override history and display the case in the supervisor pending review dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

DELETE FROM cjams.routing
WHERE routingid='0c9d19db-421e-4724-9be2-161292ba9e10'::uuid;

DELETE FROM cjams.administrativeoverrides
WHERE administrativeoverrideid='907f4da9-5c3b-4e6c-840f-4010f9e60765'::uuid;

/*INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0c9d19db-421e-4724-9be2-161292ba9e10'::uuid, 'INTR', '72439d81-dfaa-46d0-a372-f90eb16f75fd', '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, NULL, NULL, 'I251013268371', 860, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-04-18 13:55:47.734', '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-04-18 13:55:47.734', true, 'Navigate to Narrative', NULL, 'Navigate to Narrative', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'Navigate to Narrative', NULL);*/

/*INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES('907f4da9-5c3b-4e6c-840f-4010f9e60765'::uuid, '00000000-0000-0000-0000-000000000000'::uuid, '2530', 'I251013268371', NULL, 'RISO', '2530', '2025-04-18 17:53:55.661', '2025-04-18 17:53:55.661', '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, '2025-04-18 13:55:47.734', '72439d81-dfaa-46d0-a372-f90eb16f75fd', '2025-04-18 13:55:47.734', '72439d81-dfaa-46d0-a372-f90eb16f75fd', 1, 1, '00000000-0000-0000-0000-000000000000'::uuid, NULL, NULL, NULL, NULL, false);
*/

update routing 
  set activeflag = 1, 
      eventcode = 'INTR',
      updatedon = now() 
where routingid = '7ed0c5df-7f3d-41a4-87ac-ba0b8aa0447a';

update 	intakedastaging 
SET 	updatedby = 'CJAMS-59129', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE 	intakenumber = 'I251013268371' and activeflag = 1;