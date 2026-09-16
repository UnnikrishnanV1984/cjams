/*
   Issue Description: CDM-16706
   Category/ Module  :  case approval wont go away
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

/* backup script

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0c28b290-9fef-4815-bb7b-7addd78a29a7'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 10:16:20.792', '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 10:16:20.792', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('4d1cffef-ad71-4904-960c-ae9ea60b46c5'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-09-15 13:38:56.020', '4f77059e-7efa-4df8-b810-67408df11399', '2021-09-15 13:38:56.020', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6e4f97f3-5998-4baf-b40f-1d49f884ee89'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-09-09 15:32:15.870', '4f77059e-7efa-4df8-b810-67408df11399', '2021-09-09 15:32:15.870', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('977ee2d7-f3fa-48c8-a7c0-86f4162f27cf'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 14:00:18.016', '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 14:00:18.016', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a91c42e3-5918-492c-8bd3-be4bab7bfe56'::uuid, 'PCAUTH', '3a9491d1-acde-4f67-9bf7-d260738e4494', '4f77059e-7efa-4df8-b810-67408df11399', 'cbe7780d-92b1-4760-bee7-239612dc7b48'::uuid, 'CWCW', 'CWSP', '1780227', 39, 1, '3a9491d1-acde-4f67-9bf7-d260738e4494', '2021-06-08 07:58:17.045', '3a9491d1-acde-4f67-9bf7-d260738e4494', '2021-06-08 07:58:17.045', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bebe9e45-fef7-45d5-a9f4-8e1d7da6e8d0'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-09-15 13:38:38.842', '4f77059e-7efa-4df8-b810-67408df11399', '2021-09-15 13:38:38.842', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('db7b8f2c-3365-472f-87bd-c204d6ac7999'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 08:03:30.412', '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 08:03:30.412', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ea7ea953-92cc-48dd-bdcb-46c48b434612'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 08:03:09.736', '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 08:03:09.736', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ed552853-ed7c-4040-ab83-4d95cc4f626a'::uuid, 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-06-14 15:13:26.171', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-06-14 15:13:26.171', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ef350886-2a68-4864-b079-c6ff54c4c291'::uuid, 'PCAUTHR', '4f77059e-7efa-4df8-b810-67408df11399', '1151a514-444a-4541-8209-1a8ae58813d6', '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 12:41:04.686', '4f77059e-7efa-4df8-b810-67408df11399', '2021-06-08 12:41:04.686', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('f1978fd0-1ff9-43fc-b56c-dfa6d10dbf27'::uuid, 'PCAUTHR', '68ded231-16ad-4c93-a496-273eb0a62c02', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332'::uuid, 'CWSP', 'FNSFW', '1780227', 40, 1, '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-06-14 11:26:02.243', '68ded231-16ad-4c93-a496-273eb0a62c02', '2021-06-14 11:26:02.243', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3089088', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

delete from routing where routingid in (
'a91c42e3-5918-492c-8bd3-be4bab7bfe56',
'977ee2d7-f3fa-48c8-a7c0-86f4162f27cf',
'0c28b290-9fef-4815-bb7b-7addd78a29a7',
'db7b8f2c-3365-472f-87bd-c204d6ac7999',
'ea7ea953-92cc-48dd-bdcb-46c48b434612',
'f1978fd0-1ff9-43fc-b56c-dfa6d10dbf27',
'ed552853-ed7c-4040-ab83-4d95cc4f626a',
'6e4f97f3-5998-4baf-b40f-1d49f884ee89',
'bebe9e45-fef7-45d5-a9f4-8e1d7da6e8d0',
'4d1cffef-ad71-4904-960c-ae9ea60b46c5',
'ef350886-2a68-4864-b079-c6ff54c4c291');

