
/*
   Issue Description: CDM-31062
   Category/ Module  : Assessment 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{safetyassessmentcompletiondate}', '"2023-04-26T12:21"')
where assessmentid ='eb4c03d3-29b2-4bfd-8210-4489b3864124';

update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{submissionapprovaldate}', '"2023-04-26T11:46"')
where assessmentid ='eb4c03d3-29b2-4bfd-8210-4489b3864124';

--inserting approved record
INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES( 'ASST', '38a1d30a-7382-4917-94b6-4a5759be9c33', '222e2362-21b3-4dcc-a20c-92352a7470f6', '27dcb20d-5b7a-40ca-b161-156916617a97', 'CWSP', 'CWCW', 'eb4c03d3-29b2-4bfd-8210-4489b3864124', 16, 1, '222e2362-21b3-4dcc-a20c-92352a7470f6', '2023-04-26 12:21:54.615', '222e2362-21b3-4dcc-a20c-92352a7470f6', '2023-04-26 12:21:54.615', true, '', NULL, '', '202104005883', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
