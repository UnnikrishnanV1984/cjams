update cjams.routing set activeflag=0 , tosecurityusersid='5fa4ecd6-9c66-496f-8eff-e32c78192df1',
updatedby='5fa4ecd6-9c66-496f-8eff-e32c78192df1', updatedon='2020-02-22 15:09:06' where routingid = '164fa232-c41d-4128-a7c5-3fc317928ebb' and objectid=1731575;

delete from routing where routingid='5dbe1776-21ba-4d87-91b2-5353e28f1e0c' and objectid=1731575;

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid)
VALUES('5dbe1776-21ba-4d87-91b2-5353e28f1e0c', 'PCAUTHR', '5fa4ecd6-9c66-496f-8eff-e32c78192df1', 'bf03163b-8f6c-42dd-88f8-02ea79c883f9', '086c273a-f92b-4578-a44d-9f77994adcd2', 'FNSFS', 'FNSFS', '1731575', 43, 1, '5fa4ecd6-9c66-496f-8eff-e32c78192df1', '2020-02-22 15:09:06', 'bf03163b-8f6c-42dd-88f8-02ea79c883f9', '2020-02-22 16:13:37.143', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', '3297553', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
