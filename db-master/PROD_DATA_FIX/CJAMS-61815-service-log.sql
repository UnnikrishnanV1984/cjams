/*
-- Category/ Module: service log
-- Root cause: old record have the data insertation issue back in 2021 for the finance module
    and has been resolved back then with the codefix.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('aaefe5c8-4ac5-4679-936f-e1ed0197e095'::uuid, 'PCAUTHR', '362086ed-9366-451c-b7c1-b623d6de193b', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1770693', 40, 1, '362086ed-9366-451c-b7c1-b623d6de193b', '2021-12-08 11:14:25.986', '362086ed-9366-451c-b7c1-b623d6de193b', '2021-12-08 11:14:25.986', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3276291', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='aaefe5c8-4ac5-4679-936f-e1ed0197e095'::uuid;

update routing 
set activeflag =1,
	updatedby = 'CJAMS-61815',
	updatedon = now()
where routingid = '5d784232-ebad-4e4e-87ba-e6a87816b9ad'
	and activeflag =0;