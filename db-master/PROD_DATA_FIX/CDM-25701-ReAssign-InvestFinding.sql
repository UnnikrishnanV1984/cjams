/*
   Issue Description: CDM-25701
   Category/ Module  : Investigation Finding
   Root cause: user wants assign the case to appeal worker
   Pull request# for code fix: 6849
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update caseassignment 
set toworkeridno = 'b28a47f7-fb75-4f4e-9e15-da1ea41d71c3', updatedon = now(), updatedby = 'CDM-25701'
where caseassignmentid = 'b19c3c3e-c668-4058-a27a-fa325a5ab7a0';

--appeal case dashboard

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('APPL', '', 'b28a47f7-fb75-4f4e-9e15-da1ea41d71c3', 'aa902e82-ef46-43f2-81c8-b24fa69c3ed2', 'CWSP', 'CWAPPEALCO', '6e8e3af2-4dfc-4365-aaf2-2581ab626b9e', 15, 1, '', '2022-11-17 10:20:07', 'CDM-25701', now(), false, null, null, NULL, NULL, NULL, null, null, NULL, NULL, null, null, NULL, NULL);
