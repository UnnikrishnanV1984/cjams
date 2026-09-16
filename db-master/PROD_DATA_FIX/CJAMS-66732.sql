/*
-- Issue Description: override, now won't let me change referral
   
-- Category/ Module: Disposition
-- Root cause: User Requested to remove submission record and override record  for the intake.
-- Fix Provided: Data fix is done to remove the submission record and override record for the intake
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE intakesnapshot
SET
updatedby = 'CJAMS-66732', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013984676' AND activeflag=1;

UPDATE intakedastaging
SET
updatedby = 'CJAMS-66732', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013984676' AND activeflag=1;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', '47dc653d-9089-4b47-b40e-0168ef6c2321', '47dc653d-9089-4b47-b40e-0168ef6c2321', NULL, NULL, NULL, 'I261013984676', 8, 0, '47dc653d-9089-4b47-b40e-0168ef6c2321', '2026-03-30 09:25:05.950', '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), true, 'Navigate to Narrative', NULL, 'Navigate to Narrative', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'screenout', NULL);