DELETE from routing where objectid = '106e6606-8c3b-474f-b94c-7d95131030a6' and activeflag=1 and eventcode = 'CHRR';
		
INSERT INTO routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
 fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
 remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid)
VALUES(gen_random_uuid(), 'CHRR', '023096a8-0092-406d-9693-a579ecff842e', '07973380-5006-4c77-a5f5-8194e523a481', '8b52b065-f31c-49cd-a3e5-815ea83dab8e',
	   'CWCW', 'CWSP','106e6606-8c3b-474f-b94c-7d95131030a6', 15, 1, 'Datafix user as per CDM-1476', now(), 'Datafix user as per CDM-1476', now(), true, 
	   'Child Removal Submitted for review', '', 'Servicecase', '3302235', '', '', '', '', null, '', null, '');