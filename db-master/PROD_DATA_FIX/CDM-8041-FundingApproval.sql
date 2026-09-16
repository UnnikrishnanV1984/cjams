/*
   Issue Description: CDM-8041 --  Can't approve Funding
   Category/ Module  :  Service log
   Root cause: This is unable to reproduce in stage
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

Auth #:1755051
Case #: 3270971
backup before deletion:
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('18e8ecf9-bd43-4920-a565-d4bac39dc1fe', 'PCAUTHR', 'f2599061-b9c9-455f-a9c8-c7bc31e9ef22', 'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9', '4cde989e-2c03-40af-b733-a9e9e17310fd', 'CWSP', 'FNSFW', '1755051', 40, 1, 'f2599061-b9c9-455f-a9c8-c7bc31e9ef22', '2020-12-14 14:47:58.528', 'f2599061-b9c9-455f-a9c8-c7bc31e9ef22', '2020-12-14 14:47:58.528', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3270971', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('098f1817-6617-46bc-beda-0b2a0439d105', 'PCAUTHR', '5fa4ecd6-9c66-496f-8eff-e32c78192df1', '5fa4ecd6-9c66-496f-8eff-e32c78192df1', '4cde989e-2c03-40af-b733-a9e9e17310fd', 'FNSFS', 'FNSFS', '1755051', 43, 1, '5fa4ecd6-9c66-496f-8eff-e32c78192df1', '2020-12-16 16:41:06.732', '5fa4ecd6-9c66-496f-8eff-e32c78192df1', '2020-12-16 16:41:06.732', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
delete from routing where objectid=1755051 and routingstatustypeid in (40,43) and activeflag=1
and routingid in ('18e8ecf9-bd43-4920-a565-d4bac39dc1fe','098f1817-6617-46bc-beda-0b2a0439d105');