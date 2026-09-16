/*
 Issue Description: CDM-10554 --payment request
   Category/ Module  :  payment approval
   Root cause: unalbe to reproduce it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
Backup:
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('69619544-035d-487c-8e1d-dc08a76134d7', 'PCAUTH', '857bc591-61f8-4ca8-9d20-7aa3b22cc3d8', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '62b1466f-6acd-44ab-a561-6784419dd3ef', 'CWCW', 'CWSP', '1762876', 850, 1, '857bc591-61f8-4ca8-9d20-7aa3b22cc3d8', '2021-02-17 11:44:49.399', '857bc591-61f8-4ca8-9d20-7aa3b22cc3d8', '2021-02-17 11:44:49.399', true, 'Returned', NULL, 'change code to 4110', '3277975', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
		
	delete from routing where routingid='69619544-035d-487c-8e1d-dc08a76134d7' and routingstatustypeid=850;	
		
	