/*
   Issue Description: CDM-28793
   Category/ Module  :Manual Receivable routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('MANREC', '474229ae-a4d6-4857-8c68-569349ec9552', '462dcfba-84ac-4672-924a-db788066371a', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c', 'FNSFS', 'FNSFS', '1727016', 73, 1, '474229ae-a4d6-4857-8c68-569349ec9552', now(), 'CDM-28793', now(), true, 'Manual Account Receivable Request', NULL, 'Manual Account Receivable Request for Ancillary payment id (3329248) ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
