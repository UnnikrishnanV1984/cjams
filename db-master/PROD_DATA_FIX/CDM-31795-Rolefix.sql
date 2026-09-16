/*
   Issue Description: CDM-31795
   Category/ Module  : User Profile 
   Root cause: updating correct role 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE cjams.teammember
SET roletypekey='CWCW', updatedby='CDM-31795', updatedon=now()
WHERE teammemberid='cef41add-03b6-4ab3-bb94-6de2638606cc' and activeflag=1;

	
	---Inserting  approved GAYR eventcode record 	
		
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'GAYR', '66a80882-f231-4882-a573-1b5a32c8e271', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '85802412-97aa-4f41-8e35-52f682c643f8', 'CWSP', 'CWCW', '6035e72d-8373-4c7a-8c26-e4f1c9f55799', 16, 1, '66a80882-f231-4882-a573-1b5a32c8e271', '2023-06-02 17:30:20', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-06-02 17:30:20', true, 'Annual Review Submitted for review', NULL, '', '2020021702165', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	
	