 /*
  Issue Description: CDM-22159 Wrong county
   Category/ Module  :  wrong county
   Root cause:
   Pull request# for code fix: already code fix is done
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
   --INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('66996c69-7be5-49b5-83f8-06929e653e5f', 'PCAUTH', '3a9491d1-acde-4f67-9bf7-d260738e4494', '4f77059e-7efa-4df8-b810-67408df11399', 'cbe7780d-92b1-4760-bee7-239612dc7b48', 'CWCW', 'CWSP', '1813943', 39, 1, '3a9491d1-acde-4f67-9bf7-d260738e4494', '2022-01-13 08:19:57.542', '3a9491d1-acde-4f67-9bf7-d260738e4494', '2022-01-13 08:19:57.542', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3047513', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('2aaff69d-8976-4ca6-9c55-03bc510c365e', 'PCAUTHR', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', NULL, '197c1f06-75ec-4191-a7bd-2807c10e4332', 'CWSP', 'FNSFW', '1813943', 40, 1, '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2022-07-01 15:52:47.259', '55c8ea0d-98d3-455a-98ec-db067c1ec65d', '2022-07-01 15:52:47.259', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3047513', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

delete from routing where objectid=1813943 and
routingid in ('66996c69-7be5-49b5-83f8-06929e653e5f','2aaff69d-8976-4ca6-9c55-03bc510c365e');