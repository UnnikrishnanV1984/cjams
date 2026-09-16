 /*
Issue Description: CDM-32270
Root Cause :user is not able finish exit placement
Data fix :Updated role type, deleted routing records
Category/ Module: Placement
Pull request# N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A
updating comments
*/
update teammember 
set roletypekey ='CWCW',
updatedby ='CDM-32270',
updatedon =now() 
where teammemberid = '338d29ca-c9fe-4005-b7c0-85f2d8fb4e42' ;

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1a22befd-1f13-45c8-9bac-af5fa644010b', 'PLTR', '5ccbd09e-bff1-44b1-b980-52ca4a411f6a', '5b366c60-e112-4b90-95c5-e6457c11f2d9', '945a7955-d865-4520-abb0-b908b31db7c8', 'VENDORAPP', 'CWSP', '18660bbc-61dd-4245-9f65-e5ede9d2ea5a', 15, 0, '5ccbd09e-bff1-44b1-b980-52ca4a411f6a', '2023-06-21 10:03:06.274', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2023-06-21 10:05:16.827', true, '', NULL, 'Placement Exit Submitted for review', '3247839', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2d472c3a-378f-4d37-a60e-8488010d797a', 'PLTR', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', NULL, NULL, 'CWSP', 'IVESV', '18660bbc-61dd-4245-9f65-e5ede9d2ea5a', 16, 1, 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '2023-06-21 08:30:20.187', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '2023-06-21 08:30:20.187', false, NULL, NULL, NULL, '3247839', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('62d48a17-c068-4c2c-bbdd-10eda38c64ed', 'PLTR', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', NULL, NULL, 'CWSP', 'IVESV', '18660bbc-61dd-4245-9f65-e5ede9d2ea5a', 16, 1, '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2023-06-21 10:05:16.827', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '2023-06-21 10:05:16.827', false, NULL, NULL, NULL, '3247839', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

delete from routing where routingid  in ('1a22befd-1f13-45c8-9bac-af5fa644010b','2d472c3a-378f-4d37-a60e-8488010d797a','62d48a17-c068-4c2c-bbdd-10eda38c64ed') ;

update routing set activeflag = 1, updatedby = 'CDM-32270',updatedon =now() where routingid = '9c4db9ff-5f22-40ae-b08b-1d0eb2a955db';