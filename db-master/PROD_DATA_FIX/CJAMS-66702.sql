/*
-- Issue Description: override, now won't let me change referral
   
-- Category/ Module: Disposition
-- Root cause: User Requested to remove last two submission records for the intake.
-- Fix Provided: Data fix is done to remove the last two submission records for the intake
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update cjams.intakeservicerequest
    set activeflag = 0,
        intakenumber = null,
        updatedon = now(),
        updatedby = 'CJAMS-66702'
    where intakeserviceid = 'a53cdab7-ca9c-419d-9a56-71eef321da1e';

delete from cjams.administrativeoverrides where entityid = 'I261013985569';

/* INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES('cc6ac82c-e3de-400d-8b21-e9a7e26606c3', '00000000-0000-0000-0000-000000000000', '2530', 'I261013985569', '7c4506d2-dc26-4874-9cd7-dc6a8eed770b', 'RISI', '2530', '2026-03-27 11:48:38.629', '2026-03-27 11:48:38.629', '8c27171c-3dc5-4b93-8d18-52b63c489075', 'Please change to a ROH trafficking, no disclosure made', '2026-03-27 07:49:15.651', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:55:51.231', '8c27171c-3dc5-4b93-8d18-52b63c489075', 0, 1, '00000000-0000-0000-0000-000000000000', NULL, NULL, NULL, '2026-03-26 16:31:42.641', false);
INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES('3806144f-d2a5-4d3c-b397-a198db140f88', '00000000-0000-0000-0000-000000000000', '2530', 'I261013985569', '840dd38f-0831-45c2-a8dd-3d22a09d8427', 'ITMS', '2530', '2026-03-27 14:47:57.573', '2026-03-27 14:47:57.573', '8c27171c-3dc5-4b93-8d18-52b63c489075', NULL, '2026-03-27 10:49:43.439', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:55:51.231', '8c27171c-3dc5-4b93-8d18-52b63c489075', 0, 1, '00000000-0000-0000-0000-000000000000', NULL, NULL, NULL, '2026-03-26 16:31:42.641', false);
INSERT INTO cjams.administrativeoverrides
(administrativeoverrideid, approvalid, entitytypekey, entityid, referralsnapshotid, overridereasontypekey, overridetypekey, overridedate, overridetimestamp, overridestaffid, "comments", insertedon, insertedby, updatedon, updatedby, activeflag, overridekeyid, intakeserviceid, old_id, etl_userid, etl_load_date, intakeapproveddate, contactmadewithhhmember)
VALUES('abd06d3e-8c93-40e4-8ed9-d4185508fa73', '00000000-0000-0000-0000-000000000000', '2530', 'I261013985569', 'ee7fbb24-7644-42dd-a0fb-6bcb8d8709ef', 'RISI', '2530', '2026-03-27 14:54:39.100', '2026-03-27 14:54:39.100', '8c27171c-3dc5-4b93-8d18-52b63c489075', NULL, '2026-03-27 10:55:51.231', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:55:51.231', '8c27171c-3dc5-4b93-8d18-52b63c489075', 1, 1, '00000000-0000-0000-0000-000000000000', NULL, NULL, NULL, '2026-03-26 16:31:42.641', false); */

UPDATE cjams.intakedastaging
SET jsondata = jsonb_set(
					jsonb_set(
						jsonb_set(
							jsondata, 
							'{General, addendumNarrative}', '""'
						),
						'{DAType, DATypeDetail, 0, supDisposition}', '""'
					),
					'{disposition, 0, supDisposition}', '""'),
	updatedby = 'CJAMS-66702',
	updatedon = now()
	WHERE intakenumber IN ('I261013985569')
	and activeflag = 1;
        
UPDATE cjams.intakedastatus
SET jsondata = jsonb_set(
					jsonb_set(
						jsonb_set(
							jsondata, 
							'{General, addendumNarrative}', '""'
						),
						'{DAType, DATypeDetail, 0, supDisposition}', '""'
					),
					'{disposition, 0, supDisposition}', '""'),
	status = null,
    updatedby = 'CJAMS-66702',
	updatedon = now()
	WHERE intakenumber IN ('I261013985569')
	and activeflag = 1;

DELETE FROM cjams.routing
WHERE routingid='6ab41388-8b66-4bee-8abf-cb412a760994'::uuid;

update cjams.intakesnapshot
    set activeflag = 0,
        updatedon = now(),
        updatedby = 'CJAMS-66702'
    where intakenumber =  'I261013985569'
        and activeflag = 1;

/*

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6ab41388-8b66-4bee-8abf-cb412a760994'::uuid, 'INTR', '8c27171c-3dc5-4b93-8d18-52b63c489075', '141e7c84-1e17-4ddd-a10a-b8072694bfbf', '761524bf-710d-4f07-96b9-eb4e96ff724b'::uuid, 'CWSP', 'CWIW', 'I261013985569', 861, 0, '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 07:49:15.651', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:49:43.439', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', 'Return to Worker', NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='8b3735a6-35d1-4121-87df-3900b78b1081'::uuid;

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8b3735a6-35d1-4121-87df-3900b78b1081'::uuid, 'INTR', '141e7c84-1e17-4ddd-a10a-b8072694bfbf', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b'::uuid, 'CWIW', 'CWSP', 'I261013985569', 1, 0, '141e7c84-1e17-4ddd-a10a-b8072694bfbf', '2026-03-26 16:03:14.841', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 07:49:15.651', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='835610e8-12de-4cef-b5d8-08e8b78e7792'::uuid;

/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('835610e8-12de-4cef-b5d8-08e8b78e7792'::uuid, 'INTR', '141e7c84-1e17-4ddd-a10a-b8072694bfbf', '01e714f6-a2ca-4386-844d-dc4ecedf9c15', '761524bf-710d-4f07-96b9-eb4e96ff724b'::uuid, 'CWIW', 'CWSP', 'I261013985569', 2, 0, '01e714f6-a2ca-4386-844d-dc4ecedf9c15', '2026-03-26 16:31:42.641', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 07:49:15.651', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'scrnin', 'scrnin', '2026-03-26 16:31:42.641');

 */

DELETE FROM cjams.routing
WHERE routingid='8514cbb7-87f1-455f-86df-8703b515780a'::uuid;

/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8514cbb7-87f1-455f-86df-8703b515780a'::uuid, 'INTR', '8c27171c-3dc5-4b93-8d18-52b63c489075', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b'::uuid, 'CWIW', 'CWSP', 'I261013985569', 861, 0, '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:49:43.439', '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:55:51.231', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', 'Return to Worker', NULL);

 */

DELETE FROM cjams.routing
WHERE routingid='42ac4c36-3c3e-4492-9ac0-103bdc34ad2d'::uuid;


/*
  INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('42ac4c36-3c3e-4492-9ac0-103bdc34ad2d'::uuid, 'INTR', '8c27171c-3dc5-4b93-8d18-52b63c489075', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b'::uuid, 'CWSP', 'CWIW', 'I261013985569', 861, 0, '8c27171c-3dc5-4b93-8d18-52b63c489075', '2026-03-27 10:55:51.231', '47dc653d-9089-4b47-b40e-0168ef6c2321', '2026-03-30 10:00:29.441', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', 'Return to Worker', NULL);

 */

