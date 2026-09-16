/*
   Issue Description: CDM-8261 Payment Nor being processed
   Category/ Module  :  Service log
   Root cause: Unable to reproduce it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup:
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('36e17f0b-447e-4730-acca-2925a2bbd75c', 'PCAUTHR', 'd4edc3f7-7cf6-43f9-b080-f32f03625d97', '96a859fb-b8ca-49ef-a609-d3a3dcdf2f7a', '4cde989e-2c03-40af-b733-a9e9e17310fd', 'CWSP', 'FNSFS', '1748972', 40, 1, 'd4edc3f7-7cf6-43f9-b080-f32f03625d97', '2020-11-02 15:20:10.747', 'd4edc3f7-7cf6-43f9-b080-f32f03625d97', '2020-11-02 15:20:10.747', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3285641', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
delete from routing where objectid=1748972 
and routingstatustypeid=40 and activeflag=1
and routingid='36e17f0b-447e-4730-acca-2925a2bbd75c';