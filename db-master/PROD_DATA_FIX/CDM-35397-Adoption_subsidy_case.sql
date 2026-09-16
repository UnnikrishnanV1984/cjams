-- Adoption Case ID: 231040214007 - 7ef8b110-bec8-4b01-9b5c-2794e165c703 
-- Client ID: 202078831 (Josslyn Alexander) - 1273b844-7332-4fef-bb87-abcca7e2b97f
-- Provider ID: 6085134	(MAURIA ELIZABETH UHLIK) - Local Department Home
-- Applicant: 202067660 (MAURIA ELIZABETH UHLIK) - 36e0304b-27d1-400a-949c-f7b5b8b7246b 
-- Co-Applicant: 202067662 (David Vernon Fegley) - f66a0669-1d1f-4d97-aba3-72a2372dff1d

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Private Adoption cases, ths flow is currently NOT working in CJAMS. 
--             CJAMS is creating adoption cases with incomplete data set.  
-- Fix Provided: Datafix has been provided to fix this Private Adoption case data, please ask the user to add the rate in CJAMS. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- Update alternateid (adoption_id) used for Payment generation tb_adoption
select adoptioncasenumber, alternateid, statustypekey, startdate, enddate, updatedby, updatedon 
	from adoptioncase 
where adoptioncasenumber = '231040214007'
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2023-11-16 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2034-02-06 00:00:00.000',
	updatedby = 'CDM-35397',
	updatedon = now()
where adoptioncasenumber = '231040214007'
	and activeflag = 1 ;

-- Update Adopted Child Role 
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = '772d6853-03c6-4dee-9e8a-e923739ef47f'
	and activeflag = 1 ;

update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-35397' 
where adoptioncaseactorid  = '772d6853-03c6-4dee-9e8a-e923739ef47f'
	and activeflag = 1 ;

Delete from adoptioncaseagreement where insertedby = 'CDM-35397';

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
	(	'7ef8b110-bec8-4b01-9b5c-2794e165c703', 1, '2023-11-16 00:00:00.000', 
		'2023-11-16 00:00:00.000', '2034-02-06 00:00:00.000', '2023-11-16 00:00:00.000',  NULL,
		'2022-08-29 00:00:00.000', '2022-08-29 00:00:00.000', '2022-08-29 00:00:00.000', 1,
		1, now(), 'CDM-35397',  now(), 'CDM-35397', now(),
		NULL, NULL, 6085134, 6085134, 'MAURIA ELIZABETH UHLIK', 'DAVID VERNON FEGLEY',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, NULL, 'iveag', 'wtinst',
		'TIAAA', 6085134, 603120, 603121
	);
	
Delete from routing where insertedby = 'CDM-35397' and eventcode = 'ASAR';
	
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
	(	'ASAR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', -- 	Jecelyn Litzenberger
		'5e46d48e-82ff-45dc-9b4d-e68edb67cafc', -- Emily Mills 
		'ca9a68a7-3cfa-4f3d-999e-2f0785604dab',  -- Adoptions ,
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '7ef8b110-bec8-4b01-9b5c-2794e165c703' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-35397',  now(), 'CDM-35397', now(),
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 231040214007,
		NULL, NULL, NULL, NULL
	);	
		

-- Add Adoptive Parents
Delete from adoptioncaseactor where insertedby = 'CDM-35397' ;

-- Applicant: 202067660 (Mauria Elizabeth Uhlik) - 36e0304b-27d1-400a-949c-f7b5b8b7246b
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '7ef8b110-bec8-4b01-9b5c-2794e165c703', 
		'36e0304b-27d1-400a-949c-f7b5b8b7246b', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-35397', now(), 'CDM-35397', NULL, NULL
	);
	
-- Co-Applicant: 202067662 (David Vernon Fegley) - f66a0669-1d1f-4d97-aba3-72a2372dff1d
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '7ef8b110-bec8-4b01-9b5c-2794e165c703', 
		'f66a0669-1d1f-4d97-aba3-72a2372dff1d', 'ADOPTIVEPARENT',
		1, now(), 'CDM-35397', now(), 'CDM-35397', NULL, NULL
	);