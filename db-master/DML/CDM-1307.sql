DELETE  FROM cjams.routing
	where objectid = 'a29fc7d5-e547-4a82-91ee-a2e52dcb120e' and activeflag=1 and eventcode = 'PLTR'  
	and toroleid = 'CWCW' ;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
 fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid)
VALUES(gen_random_uuid(), 'PLTR', '7a8cd264-8789-4016-9bb1-353a27d24785', 'b4ba111f-522f-4617-8185-05f766d5e436', 'b8d4d6d4-bd06-4087-b38a-b085abb266db',
	   'CWSP', 'CWCW', 'a29fc7d5-e547-4a82-91ee-a2e52dcb120e', 16, 1, 'Datafix user as per CDM-1307', now(), 'Datafix user as per CDM-1307', now(), true, '', '', 'Child PlacementApproved', '3305044', '', '', '', '', null, '', null, '');
