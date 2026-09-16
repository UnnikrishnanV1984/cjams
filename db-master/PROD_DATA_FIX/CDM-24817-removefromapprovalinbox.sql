/*
   Issue Description: CDM-24817
   Category/ Module  : Approval inbox
   Root cause: User wants to delete from approval inbox
*/

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5ce15455-cebb-423a-9b31-e028753c6377'::uuid, 'PCAUTH', 'ce049eee-c805-4af5-954e-f47d023a7a26', 'a4aeca9f-af88-43f7-83c9-153ae53da4b2', '34760fc4-fade-40aa-82c5-3fc8273b2dc2'::uuid, 'CWCW', 'CWSP', '1826455', 39, 1, 'ce049eee-c805-4af5-954e-f47d023a7a26', '2022-04-05 15:53:56.693', 'ce049eee-c805-4af5-954e-f47d023a7a26', '2022-04-05 15:53:56.693', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3122284', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete from routing where routingid = '5ce15455-cebb-423a-9b31-e028753c6377';

update tb_service_purchase_authorization 
set sprvsr_approval_status_cd = '3281',
	update_user_id = 'CDM-24817',
	update_ts = now()
where authorization_id = '1826455';

update routing 
set activeflag = 0,
	updatedby = 'CDM-24817',
	updatedon = now()
where routingid in ('22c2e771-5350-42ed-8df8-2d8951c3be0c', '63df7e19-b493-42ef-84ff-2b5c913a4657');