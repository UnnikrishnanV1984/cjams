/*
   Issue Description: CDM-43947
   Category/ Module : Intake
   Root cause: Intake was not able to approve by supervisor
   Fix Provided: Did data fix to delete the already approved wrong record

*/

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('838833b1-2b4c-4fcf-b49c-ab87afe6a6af'::uuid, 'INTR', 'b255a03d-2c2d-4e32-a6c8-d16181d97b63', 'b255a03d-2c2d-4e32-a6c8-d16181d97b63', 'a6868fd8-e950-4c3f-bee0-4bf73ca4b9fd'::uuid, 'CWSP', 'CWSP', 'I251013212750', 8, 0, 'b255a03d-2c2d-4e32-a6c8-d16181d97b63', '2025-01-22 09:02:09.535', 'b255a03d-2c2d-4e32-a6c8-d16181d97b63', '2025-01-22 09:02:09.535', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Closed', NULL, '2025-01-22 09:02:09.535');


DELETE FROM cjams.routing
WHERE routingid='838833b1-2b4c-4fcf-b49c-ab87afe6a6af'::uuid and objectid ='I251013212750';


update intakedastatus
set status = null,
updatedon = now(),
updatedby = 'CDM-43947'
where intakenumber = 'I251013212750';

update intakedastaging
set ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-43947'
where intakenumber = 'I251013212750' and activeflag = 1;

UPDATE intakesnapshot 
SET 
updatedby = 'CDM-43947', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I251013212750' AND activeflag=1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-43947', 
updatedon = now()
where intakeserviceid ='6b90a016-8804-4366-8c64-ee9932928cac' and activeflag = 1; 