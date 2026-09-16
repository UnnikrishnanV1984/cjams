/* Issue Description:CDM-14205 - Removing pending removal records
   Category/ Module  :  Service cases authorization id records
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/


-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES(gen_random_uuid(), '9c98cfc8-bfde-4e76-b245-eae567541c15', 'PCAUTHR', 'fbfb568e-6760-4b0b-aabb-856d9c3892db',NULL , '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c', 'FNSFS', 'FNSFS', 0, 1, '1768100', now(), '', now(), false, '41', '1', 'fbfb568e-6760-4b0b-aabb-856d9c3892db', '2021-05-14 10:23:52', 'fbfb568e-6760-4b0b-aabb-856d9c3892db', '2021-05-14 10:23:52', 'true', 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', null, 'ServiceCase', null, null, null,null,null,null);

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES(gen_random_uuid(), 'b210d7ce-29f1-4928-9084-444f1fe6b7dc', 'PCAUTHR', '474229ae-a4d6-4857-8c68-569349ec9552',bf93883d-7176-446d-89ac-d631d63c9400 , '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c', 'FNSFS', 'FNSFS', 0, 1, '1768100', now(), '', now(), false, '41', '1', 'fbfb568e-6760-4b0b-aabb-856d9c3892db', '2021-05-14 10:23:52', 'fbfb568e-6760-4b0b-aabb-856d9c3892db', '2021-05-14 10:23:52', 'true', 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', null, 'ServiceCase', null, null, null,null,null,null);

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES(gen_random_uuid(), '52a36494-161b-44ac-885a-b96777cdcd95', 'PCAUTHR', '4103969d-6c19-4065-8d86-fa7706680634', bf93883d-7176-446d-89ac-d631d63c9400 , '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c', 'FNSFS', 'FNSFS', 0, 1, '1768100', now(), '', now(), false, '41', '1', 'fbfb568e-6760-4b0b-aabb-856d9c3892db', '2021-05-14 10:23:52', 'fbfb568e-6760-4b0b-aabb-856d9c3892db', '2021-05-14 10:23:52', 'true', 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', null, 'ServiceCase', null, null, null,null,null,null);


Delete  from routing where routingid in (
'52a36494-161b-44ac-885a-b96777cdcd95',
'b210d7ce-29f1-4928-9084-444f1fe6b7dc',
'9c98cfc8-bfde-4e76-b245-eae567541c15' ) 
and
objectid  = '1768100';