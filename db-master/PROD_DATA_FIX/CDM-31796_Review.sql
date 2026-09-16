/*
   Issue Description: CDM-31796
   Category/ Module  : User Profile/Routing 
   Root cause: updating correct role 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--User role issue resolved 
--just briging apporved record 

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(), 'GAYR', '66a80882-f231-4882-a573-1b5a32c8e271', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '85802412-97aa-4f41-8e35-52f682c643f8', 'CWSP', 'CWCW', '593cb3f0-c023-4d51-911a-4f2108da600a', 16, 1, '66a80882-f231-4882-a573-1b5a32c8e271', '2023-06-02 17:42:27.907', '66a80882-f231-4882-a573-1b5a32c8e271', '2023-06-02 17:42:27.907', true, 'Annual Review Submitted for review', NULL, '', '3298645', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	