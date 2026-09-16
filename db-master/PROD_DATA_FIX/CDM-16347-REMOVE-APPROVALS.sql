/*
   Issue Description: CDM-16437
      Category/ Module  : approvals remove
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to remove
  */

  /*

  BACKUP :

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0042f11f-1013-43bb-b1ac-de648798ccb6'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1776758', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-05-18 12:40:31.822', '4f77059e-7efa-4df8-b810-67408df11399', '2021-05-18 12:40:31.822', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '2021010907347', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('387ed722-9e4d-4aa7-9fad-c540871b89eb'::uuid, 'PCAUTHR', '63ec2281-6903-4191-848b-e53d89ef63bc', '55f4400e-7151-48f5-958b-33bd82b0ece5', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1748256', 40, 1, '63ec2281-6903-4191-848b-e53d89ef63bc', '2020-10-28 08:09:44.219', '63ec2281-6903-4191-848b-e53d89ef63bc', '2020-10-28 08:09:44.219', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3239221', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('da363806-8eff-4bb0-9309-ada04a2ebaa7'::uuid, 'PCAUTH', '55f4400e-7151-48f5-958b-33bd82b0ece5', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'FNSFW', 'FNSFS', '1747517', 43, 1, '55f4400e-7151-48f5-958b-33bd82b0ece5', '2020-10-22 11:24:55.051', '55f4400e-7151-48f5-958b-33bd82b0ece5', '2020-10-22 11:24:55.051', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('786e5d45-39b5-449f-baf7-47063dd76b30'::uuid, 'PCAUTHR', '63ec2281-6903-4191-848b-e53d89ef63bc', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1767823', 40, 1, '63ec2281-6903-4191-848b-e53d89ef63bc', '2021-03-24 13:18:59.979', '63ec2281-6903-4191-848b-e53d89ef63bc', '2021-03-24 13:18:59.979', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051006', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ca9a5488-57fe-403c-a836-445d893fbfef'::uuid, 'PCAUTHR', '63ec2281-6903-4191-848b-e53d89ef63bc', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1777273', 40, 1, '63ec2281-6903-4191-848b-e53d89ef63bc', '2021-05-20 13:21:44.513', '63ec2281-6903-4191-848b-e53d89ef63bc', '2021-05-20 13:21:44.513', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3297165', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/


delete from routing 
where routingid in  (
'da363806-8eff-4bb0-9309-ada04a2ebaa7', 
'ca9a5488-57fe-403c-a836-445d893fbfef', 
'0042f11f-1013-43bb-b1ac-de648798ccb6', 
'786e5d45-39b5-449f-baf7-47063dd76b30', 
'387ed722-9e4d-4aa7-9fad-c540871b89eb'
);