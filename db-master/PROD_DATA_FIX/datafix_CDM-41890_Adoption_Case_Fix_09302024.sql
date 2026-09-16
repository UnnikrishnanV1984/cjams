-- CDM-41890 - Unable to process private adoption in CJAMS
/*
-- Issue Description: 
   Private adoption case data fix
      

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Private Adoption Intake flow is currently NOT working in CJAMS.  CJAMS is creating adoption cases with incomplete data set.  
-- Fix Provided: Datafix has been provided to fix the 2 requested Private Adoption cases, please ask the users to add the adoption rates in CJAMS.
-- Regression Impacts: N/A
-- Is Code fix Required?: N/A
-- Code fix ticket#: (If Yes)
-- Reason why no related code fix: We have Private Adoption Intake flow re-design user story in the backlog.
*/

-- Update alternateid (adoption_id) used for Payment generation tb_adoption

Delete from adoptioncaseagreement where insertedby = 'CDM-41890';	
Delete from routing where insertedby = 'CDM-41890' and eventcode = 'ASAR';
Delete from adoptioncaseactor where insertedby = 'CDM-41890' ;

-- Adoption Case ID: 241040389387 - 802734ed-0cfe-4838-9c80-725071957d4c
-- Client ID: 203958522 (Matthew Anderson) - 0f90c4eb-d131-4bc6-be3d-6cbd69de0f88
-- Provider ID: 6155615	(LAUREN Nicole ANDERSON)

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2024-09-26 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2040-01-28 00:00:00.000',
	updatedby = 'CDM-41890',
	updatedon = now()
where adoptioncasenumber = '241040389387'
	and activeflag = 1 ;

-- Update Adopted Child Role 
update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-41890' 
where adoptioncaseactorid  = '111dcba5-5d63-4249-afd6-d16a3f7b5af2'
	and activeflag = 1 ;

-- Title 	IV-E Adoption assistance agreement
-- anst		Another State
-- priaug	Private agency under agreement
	
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
	(	'802734ed-0cfe-4838-9c80-725071957d4c', 1, '2024-08-02 04:00:00.000', 
		'2024-09-26 00:00:00.000', '2040-01-28 00:00:00.000', '2024-08-21 09:00:00.000',  NULL,
		'2024-08-08 09:00:00.000', '2024-08-08 09:00:00.000', '2024-08-21 09:00:00.000', 1,
		1, now(), 'CDM-41890',  now(), 'CDM-41890', now(),
		NULL, False, 6155615, 6155615, 'LAUREN Nicole ANDERSON', 'CLAYTON Matthew ANDERSON',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, NULL, 'priaug', 'anst',
		'TIAAA', 6155615, 668976, 668977
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
		'ef09e223-ee64-46f1-a6b1-c1526029a35f', -- FattimataMohamedAli
		'a7052b8f-fc1c-465b-8f4f-4a9de7e7397b', -- 	Amanda Greenwood
		'887a9853-369f-4cf5-bde2-908322c0785d',  -- Out of Home Care Administration
		'CWCW', 'CWSP', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '802734ed-0cfe-4838-9c80-725071957d4c' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		15, 0, 'CDM-41890',  '2024-09-26 05:00:00.000', 'CDM-41890', '2024-09-26 05:10:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 241040389387,
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
	(	'ASAR', 'a7052b8f-fc1c-465b-8f4f-4a9de7e7397b', -- 	Amanda Greenwood
		'ef09e223-ee64-46f1-a6b1-c1526029a35f', -- FattimataMohamedAli
		'887a9853-369f-4cf5-bde2-908322c0785d',  -- Out of Home Care Administration
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '802734ed-0cfe-4838-9c80-725071957d4c' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-41890',  '2024-09-26 05:00:00.000', 'CDM-41890', '2024-09-26 05:10:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 241040389387,
		NULL, NULL, NULL, NULL
	);	
	
	
-- Add Adoptive Parents
-- Applicant: 3828523	LAUREN	Nicole	ANDERSON	f57ddcba-d831-4ed3-817a-d112a984f05b
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '802734ed-0cfe-4838-9c80-725071957d4c', 
		'f57ddcba-d831-4ed3-817a-d112a984f05b', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-41890', now(), 'CDM-41890', NULL, NULL
	);
	
-- Co-Applicant: 200019512	CLAYTON	Matthew	ANDERSON	d9803f71-7155-46f9-ac76-ce152f0373e5	
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '802734ed-0cfe-4838-9c80-725071957d4c', 
		'd9803f71-7155-46f9-ac76-ce152f0373e5', 'ADOPTIVEPARENT',
		1, now(), 'CDM-41890', now(), 'CDM-41890', NULL, NULL
	);
	
	
-- Adoption Case ID: 241040389354 - 18fdbe9e-95d9-4b69-b55c-8730fef1e2ea
-- Client ID: 203958254	(Jackson Anderson) - a2237275-2825-43ae-b328-b81d57ffaed5 
-- Provider ID: 6155615	(LAUREN Nicole ANDERSON)

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2024-09-26 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2040-01-28 00:00:00.000',
	updatedby = 'CDM-41890',
	updatedon = now()
where adoptioncasenumber = '241040389354'
	and activeflag = 1 ;
	
-- Update Adopted Child Role 
update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-41890' 
where adoptioncaseactorid  = '4fb8c5a5-edc2-41b9-86a6-51f44a1ba6dc'
	and activeflag = 1 ;	
	
-- Title 	IV-E Adoption assistance agreement
-- anst		Another State
-- priaug	Private agency under agreement
	
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
	(	'18fdbe9e-95d9-4b69-b55c-8730fef1e2ea', 1, '2024-08-02 04:00:00.000', 
		'2024-09-26 00:00:00.000', '2040-01-28 00:00:00.000', '2024-08-21 09:00:00.000',  NULL,
		'2024-08-08 09:00:00.000', '2024-08-08 09:00:00.000', '2024-08-21 09:00:00.000', 1,
		1, now(), 'CDM-41890',  now(), 'CDM-41890', now(),
		NULL, False, 6155615, 6155615, 'LAUREN Nicole ANDERSON', 'CLAYTON Matthew ANDERSON',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, NULL, 'priaug', 'anst',
		'TIAAA', 6155615, 668976, 668977
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
		'ef09e223-ee64-46f1-a6b1-c1526029a35f', -- FattimataMohamedAli
		'a7052b8f-fc1c-465b-8f4f-4a9de7e7397b', -- 	Amanda Greenwood
		'887a9853-369f-4cf5-bde2-908322c0785d',  -- Out of Home Care Administration
		'CWCW', 'CWSP', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '18fdbe9e-95d9-4b69-b55c-8730fef1e2ea' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		15, 0, 'CDM-41890',  '2024-09-26 05:00:00.000', 'CDM-41890', '2024-09-26 05:10:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 241040389354,
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
	(	'ASAR', 'a7052b8f-fc1c-465b-8f4f-4a9de7e7397b', -- 	Amanda Greenwood
		'ef09e223-ee64-46f1-a6b1-c1526029a35f', -- FattimataMohamedAli
		'887a9853-369f-4cf5-bde2-908322c0785d',  -- Out of Home Care Administration
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '18fdbe9e-95d9-4b69-b55c-8730fef1e2ea' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-41890',  '2024-09-26 05:00:00.000', 'CDM-41890', '2024-09-26 05:10:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 241040389354,
		NULL, NULL, NULL, NULL
	);	
	
	
-- Add Adoptive Parents
-- Applicant: 3828523	LAUREN	Nicole	ANDERSON	f57ddcba-d831-4ed3-817a-d112a984f05b
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '18fdbe9e-95d9-4b69-b55c-8730fef1e2ea', 
		'f57ddcba-d831-4ed3-817a-d112a984f05b', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-41890', now(), 'CDM-41890', NULL, NULL
	);
	
-- Co-Applicant: 200019512	CLAYTON	Matthew	ANDERSON	d9803f71-7155-46f9-ac76-ce152f0373e5	
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '18fdbe9e-95d9-4b69-b55c-8730fef1e2ea', 
		'd9803f71-7155-46f9-ac76-ce152f0373e5', 'ADOPTIVEPARENT',
		1, now(), 'CDM-41890', now(), 'CDM-41890', NULL, NULL
	);		
	