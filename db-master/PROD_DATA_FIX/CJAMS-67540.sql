/*
-- Issue Description: Service log
    Case ID:  3285651
    Root cause: user requested to change the purchase authorization status as approved and remove the record which is pending and have ended the servicelog as its overlapping and user can not end from their end.
	Fix Provided: Datafix has been promoted to  modify the status of the purchase authorization and end the servicelog
    Is code fix required: N 
	Reason why no related code fix:

*/



/*
 INSERT INTO cjams.routing
(activeflag, routingstatustypeid, remarks, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(1, 40, 'Forwarded to Funding Approval', 'a95c636d-de5c-4ef5-9cd6-ced71dad77a5'::uuid, 'PCAUTHR', 'a4aeca9f-af88-43f7-83c9-153ae53da4b2', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '2416555', 40, 1, 'a4aeca9f-af88-43f7-83c9-153ae53da4b2', '2024-06-07 15:03:17.458', 'a4aeca9f-af88-43f7-83c9-153ae53da4b2', '2024-06-07 15:03:17.458', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3285651', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 */
---To modify purchase authorixation status and to delete pending routing record
DELETE FROM cjams.routing
WHERE routingid='a95c636d-de5c-4ef5-9cd6-ced71dad77a5'::uuid;

update routing 
set activeflag =1,
updatedby ='CJAMS-67540',updatedon =now()
where routingid ='0506ee8b-1d16-4ed5-b54f-a02d74a69170' and eventcode ='PCAUTHR';

update tb_service_log
set end_dt ='2025-07-24',
    update_user_id ='CJAMS-67540', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('1990044') and delete_sw='N';