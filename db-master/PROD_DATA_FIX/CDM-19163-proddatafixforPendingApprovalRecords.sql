
/*
   Issue Description: CDM-19163
   Category/ Module  : Removing Pending Approval Records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('fad6b3d9-03d7-4f15-9201-ae06849d701d'::uuid, 'PCAUTHR', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '8f8d84ad-859c-47db-bf02-b860f5f7116b', '0f493137-acfb-45a3-aa8a-c2224e383330'::uuid, 'CWSP', 'FNSFS', '1799585', 40, 1, 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '2021-11-03 10:34:24.119', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '2021-11-03 10:34:24.119', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020031704159', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('ed1816f2-dcb9-463b-aedc-13d61f363522'::uuid, 'PCAUTHR', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '8f8d84ad-859c-47db-bf02-b860f5f7116b', '381f1793-744c-4c4f-a409-809a260dcc45'::uuid, 'CWSP', 'FNSFW', '1799585', 40, 1, 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '2021-11-03 10:35:09.750', 'eca6f2d2-e3c6-474c-8c4a-d4ee53381883', '2021-11-03 10:35:09.750', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2020031704159', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete routing where routingid in ('fad6b3d9-03d7-4f15-9201-ae06849d701d','ed1816f2-dcb9-463b-aedc-13d61f363522');
