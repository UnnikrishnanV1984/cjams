/*
Issue: CJAMS-68765 Intake
Category/Module: screen out referral
Root cause: Not able to reproduce the issue in stage3 so proceeding with the datafix to screenout this intake and delete the review records from submission history
Fix provided:  Data fix is done screenout the intake  I261013986818 and remove the submission history records
Data/Code fix ticket#: CJAMS-68765
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a support ticket and user has no option to override the intake.
*/





UPDATE intakedastaging
SET
updatedby = 'CJAMS-68765', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013986818' AND activeflag=1;

/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0aabaefe-9107-4ff8-9558-b07ca7cfb4d0', 'INTR', '1896c89c-3894-44b7-aefc-b1c2a5daf596', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b', 'CWIW', 'CWSP', 'I261013986818', 1, 1, '1896c89c-3894-44b7-aefc-b1c2a5daf596', '2026-03-27 15:49:34.649', '1896c89c-3894-44b7-aefc-b1c2a5daf596', '2026-03-27 15:49:34.649', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', '', NULL);

 */

DELETE FROM cjams.routing
WHERE routingid='0aabaefe-9107-4ff8-9558-b07ca7cfb4d0';


/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('219cdd48-a0d0-46e2-86f0-2095112c2a7d', 'XXXX', '1896c89c-3894-44b7-aefc-b1c2a5daf596', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b', 'CWIW', 'CWSP', 'I261013986818', 1, 0, '1896c89c-3894-44b7-aefc-b1c2a5daf596', '2026-03-27 15:48:26.882', '1896c89c-3894-44b7-aefc-b1c2a5daf596', '2026-03-27 15:49:34.649', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', '', NULL);

 */

DELETE FROM cjams.routing
WHERE routingid='219cdd48-a0d0-46e2-86f0-2095112c2a7d';