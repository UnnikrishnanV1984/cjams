/*
    Issue Description: CDM-28137
    Category/ Module  :  
    Root cause: Inserting Gap disclosure
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, 
							activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, 
							routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
							actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INDR', '40d63914-2a9e-4abe-9616-c49bf0c269d3', '97c3dd11-db4f-42c9-bf36-02180bf2de1e', 'ee40a757-5378-409f-a7c6-118368415a99', 'CWCW', 'CWSP', 
		'30d1d1b5-caba-44ee-b50e-3c84fa2f2a00', 16, 1, 'CDM-28137', now(),
		'CDM-28137', now(), true, '', NULL, '', '221020254022', 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);