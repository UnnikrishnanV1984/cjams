 /*
  Issue Description:  CDM-25595
   Category/ Module  :  Approval inbox 
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/


update cjams.routing set activeflag=0, updatedby='CDM-25595', updatedon=now()
where routingid='8ca44171-606b-4259-a6b6-5de95b661cdd';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('68b3ccaa-c87a-4023-825e-f40aa6db32af', 'PPLR', '330d12cd-f428-41b9-b332-36e53fe5f16a', '18dcbaa8-a77d-4671-9535-c49430bed7bd', 'da6e89a1-82e1-46f7-a90e-d41a3987591d', 'CWSP', 'CWCW', '89f72cc3-fec9-449c-99e9-6fe53188bbe4', 16, 1, '18dcbaa8-a77d-4671-9535-c49430bed7bd', now(), 'CDM-25595', now(), true, 'Permanency Plan Approved', NULL, 'Permanency Plan Approved', '3266667', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



update cjams.routing set activeflag=0, updatedby='CDM-25595', updatedon=now()
where routingid='d6101efd-52b8-4db4-96c7-3888e28a12f8';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3d7f3c8d-ef21-445f-9dc1-3ce9571d090c', 'GADR', '330d12cd-f428-41b9-b332-36e53fe5f16a', '18dcbaa8-a77d-4671-9535-c49430bed7bd', 'da6e89a1-82e1-46f7-a90e-d41a3987591d', 'CWSP', 'CWCW', 'c6426b0a-46c1-4cff-afe8-58ef90c8a238', 16, 1, '18dcbaa8-a77d-4671-9535-c49430bed7bd', now(), 'CDM-25595', now(), true, 'Guardianship Disclosure Approved', NULL, 'Guardianship Disclosure Approved', '2020011101134', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



update cjams.routing set activeflag=0, updatedby='CDM-25595', updatedon=now()
where routingid='f2acc10d-e3fd-4c64-a518-3c511b3c0f3c';



INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('90bcbd18-c0ba-4478-8b44-50cd9091cbd5', 'GADR', '330d12cd-f428-41b9-b332-36e53fe5f16a', '18dcbaa8-a77d-4671-9535-c49430bed7bd', 'da6e89a1-82e1-46f7-a90e-d41a3987591d', 'CWSP', 'CWCW', '338b51b5-fc20-4b00-98a6-ecee16ccdc61', 16, 1, '18dcbaa8-a77d-4671-9535-c49430bed7bd', now(), 'CDM-25595', now(), true, 'Guardianship Disclosure Approved', NULL, 'Guardianship Disclosure Approved', '3272699', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

