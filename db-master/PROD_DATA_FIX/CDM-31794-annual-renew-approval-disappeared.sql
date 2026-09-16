/*
   Issue Description: CDM-31794
   Category/ Module  :Permanacy plan
   Root cause: annual review disappearing after approval due to user roletype
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

UPDATE cjams.teammember SET roletypekey='CWCW', updatedby='CDM-31794', updatedon=now() where teammemberid='cef41add-03b6-4ab3-bb94-6de2638606cc' and activeflag=1;


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'GAYR', '66a80882-f231-4882-a573-1b5a32c8e271', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '85802412-97aa-4f41-8e35-52f682c643f8', 'CWSP', 'CWCW', 'ad5c1404-9575-4eb4-b41e-e0914eadf014', 16, 1, '66a80882-f231-4882-a573-1b5a32c8e271', '2023-05-31 16:52:02.198', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-05-31 17:48:43.880', true, 'Annual Review Submitted for review', NULL, '', '3293500', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
