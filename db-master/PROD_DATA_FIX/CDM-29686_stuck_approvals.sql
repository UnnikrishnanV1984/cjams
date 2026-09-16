/*
   Issue Description: CDM-29686
   Category/ Module  :stuck approvals
   Root cause: :approval record not created in routing table 
   Pull request# for code fix: It's a data fix and Code fix.
   Reason why no related code fix:  
   
*/


update  routing set activeflag = 0, updatedby='CDM-29686', updatedon = NOW() where routingid= '5cf1fd11-c854-4b1e-94d0-9d1d6754a6cb';
update  routing set activeflag = 0, updatedby ='CDM-29686', updatedon = NOW() where routingid = '99f31daf-7e59-4aa4-850f-9c1029990219';

INSERT INTO cjams.routing
( eventcode,tosecurityusersid,  fromsecurityusersid,  teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'CPLAN2', '50714e61-37fc-4274-a3e4-88313c081498', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', 'f367fc82-9044-4f74-a40e-6d96db9e8625', 'CWSP', 'CWCW', '0a328f2e-b202-4a7c-8388-716e0e08f324', 16, 1, 'CDM-29686', now(), 'CDM-29686',now(), false, NULL, NULL, NULL, '3303176', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
( eventcode, tosecurityusersid, fromsecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'CPLAN2', '097281cc-d73a-40e7-ae28-85de45adebe1', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', 'f367fc82-9044-4f74-a40e-6d96db9e8625', 'CWSP', 'CWCW', '4af6e40c-cba3-41ea-b6c0-89f7773fd7ba', 16, 1,  'CDM-29686', now(), 'CDM-29686',now(), false, NULL, NULL, NULL, '3303175', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

