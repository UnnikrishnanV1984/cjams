/*
Issue Description:CJAMS-59775 Debra Williams: This provider has passed away and we have not been able to close the provider in CJAMS. It is saying there are items that have not been end dated from several years ago; however, we have not been able to fix this problem and still cannot close this provider.
Category/Module: authentication
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/



INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid,
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'PCAUTHR', '5fa4ecd6-9c66-496f-8eff-e32c78192df1', 
'bf03163b-8f6c-42dd-88f8-02ea79c883f9', '4cde989e-2c03-40af-b733-a9e9e17310fd'::uuid, 'FNSFS', 'FNSFS',
'741089', 43, 1, '5fa4ecd6-9c66-496f-8eff-e32c78192df1', now(), '5fa4ecd6-9c66-496f-8eff-e32c78192df1', 
now(), true, 'Approved', NULL, 
'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);