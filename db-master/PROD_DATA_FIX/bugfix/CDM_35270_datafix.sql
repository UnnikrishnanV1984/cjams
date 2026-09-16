
--    Issue Description: CDM-35270
--    Category/ Module  : User-Error
--    Root cause: Need Data Fix to update the Supervisor Decision as SCREENED OUT.
--    Also update the Status to CLOSED.
--    Pull request# for code fix: 
--    Reason why no related code fix: 
--    Status of the code fix if already submitted and expected prod fix date: 
--     Need to do data fix

--To change screenIn to ScreenOut in supervisor decision
UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-35270', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011396190' AND activeflag=1;
--To change status from Accepted to closed


update cjams.routing 
set routingstatustypeid = 8, activeflag = 0
where routingid ='e955d291-eafe-4a18-84b7-dad477476ade';

DELETE FROM cjams.routing
WHERE routingid in (
    'a7d1bbe8-1e95-4bf8-b752-bd9708326d50', 
    'fc7e2286-ef43-4781-98e0-4cd53215aff4', 
    '87dad7d4-5029-49f0-bebc-2222dadc83af',
    '1a828a8f-c450-4d57-8173-4febc6997dde',
    '1e322425-337b-49b4-a985-8b6d33193a3c',
    'a0f1d1ee-8abe-47ae-acbe-a08f34ddb593',
    '93fc806b-51c3-4884-b191-17e23ff39683'
);


-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('a7d1bbe8-1e95-4bf8-b752-bd9708326d50', 'XXXX', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '7cc38f64-153a-46e5-9230-bff302e8e606', 'CWIW', 'CWSP', 'I231011396190', 1, 0, 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '2023-11-09 08:18:11.766', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '2023-11-13 09:49:24.995', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('fc7e2286-ef43-4781-98e0-4cd53215aff4', 'XXXX', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '7cc38f64-153a-46e5-9230-bff302e8e606', 'CWIW', 'CWSP', 'I231011396190', 1, 0, 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '2023-11-09 08:12:55.194', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '2023-11-09 08:18:11.766', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('87dad7d4-5029-49f0-bebc-2222dadc83af', 'XXXX', 'b6548cfb-b0d4-4295-8156-3b3a0060747b', '47dc653d-9089-4b47-b40e-0168ef6c2321', '251662f5-88ee-4393-b4cc-d7c9f0b6d9a8', 'CWIW', 'CWSP', 'I231011396190', 1, 0, 'b6548cfb-b0d4-4295-8156-3b3a0060747b', '2023-11-01 11:23:32.837', '7b8708be-bbfa-4805-97fa-5149d58e991f', '2023-11-02 11:22:30.259', true, 'Talk to gma about the 4 yr old touching', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('1a828a8f-c450-4d57-8173-4febc6997dde', 'XXXX', '47dc653d-9089-4b47-b40e-0168ef6c2321', '47dc653d-9089-4b47-b40e-0168ef6c2321', '251662f5-88ee-4393-b4cc-d7c9f0b6d9a8', 'CWIW', 'CWSP', 'I231011396190', 2, 0, '47dc653d-9089-4b47-b40e-0168ef6c2321', '2023-11-01 17:01:33.602', '7b8708be-bbfa-4805-97fa-5149d58e991f', '2023-11-02 11:22:30.259', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('1e322425-337b-49b4-a985-8b6d33193a3c', 'XXXX', 'f2d9b273-d477-41d7-9fb6-fe52c9551f3b', '8c27171c-3dc5-4b93-8d18-52b63c489075', '761524bf-710d-4f07-96b9-eb4e96ff724b', 'CWIW', 'CWSP', 'I231011396190', 1, 0, 'f2d9b273-d477-41d7-9fb6-fe52c9551f3b', '2023-10-28 01:53:00.290', '7b8708be-bbfa-4805-97fa-5149d58e991f', '2023-11-02 11:22:30.259', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('a0f1d1ee-8abe-47ae-acbe-a08f34ddb593', 'XXXX', 'b6548cfb-b0d4-4295-8156-3b3a0060747b', '47dc653d-9089-4b47-b40e-0168ef6c2321', '251662f5-88ee-4393-b4cc-d7c9f0b6d9a8', 'CWIW', 'CWSP', 'I231011396190', 1, 0, 'b6548cfb-b0d4-4295-8156-3b3a0060747b', '2023-11-01 16:41:18.099', '7b8708be-bbfa-4805-97fa-5149d58e991f', '2023-11-02 11:22:30.259', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('93fc806b-51c3-4884-b191-17e23ff39683', 'XXXX', '47dc653d-9089-4b47-b40e-0168ef6c2321', 'b6548cfb-b0d4-4295-8156-3b3a0060747b', '251662f5-88ee-4393-b4cc-d7c9f0b6d9a8', 'CWSP', 'CWIW', 'I231011396190', 7, 0, '47dc653d-9089-4b47-b40e-0168ef6c2321', '2023-11-01 12:08:11.723', '7b8708be-bbfa-4805-97fa-5149d58e991f', '2023-11-02 11:22:30.259', false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
