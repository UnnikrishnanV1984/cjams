/* 
    Issue Description: CJAMS-67925
  Category/ Module  : deny service log
  Root cause: This is a migrated finance data from Chessie so data fix is needed to update the purchase authorization status as Approved so the service log can be ended
  Fix provided: Data fix has been done to modify the status to approved
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update routing 
set activeflag=0,
updatedby ='CJAMS-67925',
updatedon =now()
where routingid ='1c2d84e1-2022-4e92-8fb9-fa84157e8cf2' and eventcode ='PCAUTHR';



INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'PCAUTHR', 'f4037169-c70f-422e-8a3b-e9385f5065f9', NULL, 'a7f4e8e4-a52e-4a5b-be32-07e18959cf9c', 'CWSP', 'FNSFW', '717524', 43, 1, 'f4037169-c70f-422e-8a3b-e9385f5065f9', '2023-12-19 12:30:51.688', 'CJAMS-67925', now(), true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', '3273495', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
