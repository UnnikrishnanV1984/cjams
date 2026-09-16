/* 
    Issue Description: CDM-43979
  Category/ Module  : Service case
  Root cause: Unable to open service case.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2025-01-30 00:00:00.000',  -- Subsidy start date confirmed by the user
	enddate = '2041-05-05 00:00:00.000',
	updatedby = 'CDM-43979',
	updatedon = now()
where adoptioncasenumber = '251040451864'
	and activeflag = 1 ;


	update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-43979'
where adoptioncaseactorid  = 'f2b13b88-48c4-4015-ab06-740f816c4fb9'
	and activeflag = 1 ;

  INSERT INTO adoptioncaseagreement
	(	adoptioncaseid, isofferedsubsidy, offeraccepteddate, 
		startdate, enddate, finalizationdate, isunderappeal, 
		parent1signdate, parent2signdate, ldssdate, issubsidypaid, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
		alternateid, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, 
		adoptiveparent2signature, ldssdirectorsignature, agreementcomments, childplacedby, childplacedfrom,
		agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id
	)
values
	(	'281df002-dda7-4c6b-877e-f23a98b6caf6', 1, '2024-05-07 04:00:00.000', 
		'2025-01-30 00:00:00.000', '2041-05-05 00:00:00.000', '2024-05-08 09:00:00.000',  NULL,
		'2024-05-07 09:00:00.000', '2024-05-07 09:05:00.000', '2024-05-08 09:00:00.000', 1,
		1, now(), 'CDM-43979',  now(), 'CDM-43979', now(),
		NULL, False, 6158112, 6158112, 'Genevieve Marie Joubert', 'David Joubert',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, NULL, 'priaug', 'anst',
		'TIAAA', 6158112, 6158112, NULL
	);




    INSERT INTO routing
	(	eventcode, fromsecurityusersid, 
		tosecurityusersid, 
		teamid, 
		fromroleid, toroleid, 
		objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype
	)	
values
	(	'ASAR', 
		'6dae96ec-7172-4281-a59c-c0c6500455b2', -- Susan Lonergan  
		'0f21b527-afbb-4a4f-94b7-ce0ade354f99', -- 	 Jecelyn Litzenberger
		'0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 
		'CWCW', 'CWSP', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '281df002-dda7-4c6b-877e-f23a98b6caf6' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		15, 0, 'CDM-43979',  '2024-01-30 05:00:00.000', 'CDM-43979', '2024-01-30 05:10:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 251040451864,
		NULL, NULL, NULL, NULL
	);	
		


INSERT INTO routing
	(	eventcode, fromsecurityusersid, 
		tosecurityusersid, 
		teamid, 
		fromroleid, toroleid, 
		objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype
	)	
values
	(	'ASAR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99',
		'6dae96ec-7172-4281-a59c-c0c6500455b2', 
		'0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc',  -- Out of Home Care Administration
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '281df002-dda7-4c6b-877e-f23a98b6caf6' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-43979',  '2024-01-30 05:00:00.000', 'CDM-43979', '2024-01-30 05:10:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 251040451864,
		NULL, NULL, NULL, NULL
	);	


INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '281df002-dda7-4c6b-877e-f23a98b6caf6', 
		'0c6daa03-18b5-4632-83b7-14432e511756', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-43979', now(), 'CDM-43979', NULL, NULL
	);


    INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '281df002-dda7-4c6b-877e-f23a98b6caf6', 
		'd919f308-b2e6-4577-88fd-c61acdeaeb7e', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-43979', now(), 'CDM-43979', NULL, NULL
	);