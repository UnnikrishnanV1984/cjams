/*
   Issue Description: CDM-37638
   Category/ Module  :Dashboard Removal
   Root cause:
   Pull request# for code fix: na
   Reason why no related code fix:
   Status of the code fix if already submitted and expected prod fix date:
*/

   --3264682
update cjams.routing set activeflag =0, updatedby ='CDM-37638', updatedon = now()
where routingid ='52facadc-c9e1-4e55-9db2-c8f3101571b5'
and objectid = 'f32e8464-b6c9-4116-8f5e-ffc79e01a8cd' 
and eventcode = 'YTP'
and activeflag = 1
;

--3269050
update cjams.routing set activeflag =0, updatedby ='CDM-37638', updatedon = now()
where routingid ='c44d3a48-47ff-4a01-9032-a33004d7e21f' 
and objectid = '75b09a18-bbd5-4ab8-aa73-455897243ea3'
and eventcode = 'YTP'
and activeflag = 1
;

--211030008421
update cjams.routing set activeflag =0, updatedby ='CDM-37638', updatedon = now()
where routingid ='5435130d-8ec9-4f4d-b8ee-ff4548ceabcb' 
and objectid = 'f43c7cbd-0ad1-43b6-9f97-eb15a560c2e6'
and eventcode = 'CPLAN2'
and activeflag = 1
;

--3144777
delete from routing  
where routingid = 'cff8c2f1-5519-4a10-9de6-f54106283ade'
and objectid = '1842036' and eventcode = 'PCAUTH'
-- and activeflag = 1
;

--3279158
update cjams.routing set activeflag =0, updatedby ='CDM-37638', updatedon = now()
where routingid ='705f8b99-45af-4b15-99f2-76b0fe7347fa' and objectid = 'acc2d2c3-7af9-426d-b734-f57137469910'
and eventcode = 'CPLAN2'
and activeflag = 1
;

/*
-- To Revert the data if needed

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('cff8c2f1-5519-4a10-9de6-f54106283ade'::uuid, 'PCAUTH', 'b343fc35-3b92-4f00-a0da-c2552709c326', '6911c94c-4c9f-48cd-8385-2a73936a0c61', '96b16cd3-9894-4afa-ae33-8c92d35f615c'::uuid, 'CWCW', 'CWSP', '1842036', 39, 1, 'b343fc35-3b92-4f00-a0da-c2552709c326', '2022-07-12 10:15:15.487', 'b343fc35-3b92-4f00-a0da-c2552709c326', '2022-07-12 10:15:15.487', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3144777', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/