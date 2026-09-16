INSERT INTO routing(
		eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, 
		routingstatustypeid, insertedby, 
		updatedby, servicerequestnumber, 
		objecttypekey, routeddescription, 
		insertedon, updatedon
		) 
		VALUES 
		(
		'ADPC', '73999176-0c94-4d08-9ef2-0efe966ce506', '73999176-0c94-4d08-9ef2-0efe966ce506', 'f367fc82-9044-4f74-a40e-6d96db9e8625', 
		'CWCW', 'CWCW', '9a9bf26d-9499-4baf-b758-e84eca99ac02', 
		2, '73999176-0c94-4d08-9ef2-0efe966ce506', '73999176-0c94-4d08-9ef2-0efe966ce506', '2020011801160', 
		'adoptioncase', 'Adoption Case Created', 
		now(), now()
	);