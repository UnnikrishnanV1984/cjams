/*
   Issue Description: CDM-22522
   Category/ Module  : Delete the approval records from case pending approval
   Root cause: user wants to delete the records 
   Pull request# for code fix: 5495
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing set activeflag = 0, updatedby = 'CDM-22522', updatedon = now()
where routingid in ('db613d8e-66a6-4fb6-b7ba-01161e1ced87', '95992940-7f14-4940-a226-47dc57893c7b');

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3629eae3-456f-4378-930e-436f5317bb37', 'PCAUTH', '2ef5fdf4-1e51-41d7-94b1-157f23f52065', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '3d26c9ae-8513-43ac-8084-ea2f5b30524d', 'CWSP', 'CWSP', '1822354', 39, 1, '2ef5fdf4-1e51-41d7-94b1-157f23f52065', '2022-03-09 10:34:43.188', '2ef5fdf4-1e51-41d7-94b1-157f23f52065', '2022-03-09 10:34:43.188', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3223180', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
delete from routing where routingid = '3629eae3-456f-4378-930e-436f5317bb37';
