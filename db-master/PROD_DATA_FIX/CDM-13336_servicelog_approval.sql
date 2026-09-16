/* Issue Description:CDM-13336 Acounts Payable
   Category/ Module  :  Purchase authorization
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
Deleted data backup:
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('42f27d95-e4a4-405c-abe5-52cd9fd047f9', 'PCAUTHR', 'f156b6d0-67af-404f-bf79-d4fbd737716c', NULL, 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '1770359', 41, 1, 'f156b6d0-67af-404f-bf79-d4fbd737716c', '2021-04-13 11:19:40.821', 'f156b6d0-67af-404f-bf79-d4fbd737716c', '2021-04-13 11:19:40.821', true, 'Forwarded to Payment Approval', NULL, 'Purchase Authorization Forwarded to Payment Approval', '3301207', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/

delete from routing where routingid='42f27d95-e4a4-405c-abe5-52cd9fd047f9' and objectid=1770359;

update routing set tosecurityusersid='5bd8f401-272c-45c0-9bd1-d38a1e359d4a', updatedby='CDM-13336', 
updatedon=now() where routingstatustypeid=40
and objectid in (1770359,1770355,1770353,1770351,1770350,1770348);

update routing set fromsecurityusersid='5bd8f401-272c-45c0-9bd1-d38a1e359d4a',
teamid='b431ff54-c49b-4b06-9c1d-bef4b09c62b8', updatedby='CDM-13336', 
updatedon=now() where routingstatustypeid=41 
and objectid in (1770355,1770353,1770351,1770350,1770348);