/*
   Issue Description: CIDM-8125
   Category/ Module  : Placement routing
   Root cause: user have a placement routing pending as the from role is not cwcw or cwsp
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('PLTR', '5a7b46b1-0b9b-4ca7-aec1-0fb26ab39a16', '23f4e109-b1a3-428d-9a2c-7e3cc4470c01', '66d26714-1b71-47e1-a8b2-3f02ce51e437'
, 'CWSP', 'CWCW', 'e995a6d9-c6c2-4579-b0df-774d6cfe9d01', 16, 1, '5a7b46b1-0b9b-4ca7-aec1-0fb26ab39a16', '2023-05-17 12:35:19.530', 'CIDM-8125', now(), false, NULL, NULL, NULL, '221030034999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
