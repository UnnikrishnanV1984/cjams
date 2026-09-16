-- CDM-36215 - Private Adoption Subsidy Data Entry Issue
/*
-- Issue Description: 
   Private adoption case data issue 
      
-- Adoption Case ID: 231040250587 - e20ea328-b193-4f58-9169-5cafac443553
-- Client ID: 202564615 (Kater Morgan) - 312ec123-e4e2-4117-b008-f160df59e477
-- Provider ID: 6090786	(DAKIA MORGAN) - Local Department Home
-- Applicant: 200769956 (DAKIA MORGAN) - e788beaa-883d-40e1-bd5c-d186ad5aeb9a
-- Co-Applicant: 3826598 (HERMAN MORGAN) - 43992de8-c7f8-4e48-b4d6-1893fc26cd04


-- Category/ Module: Adoption (Case Management) 
-- Root cause: Private Adoption cases, ths flow is currently NOT working in CJAMS. 
--             CJAMS is creating adoption cases with incomplete data set.  
-- Fix Provided: Datafix has been provided to fix this Private Adoption case data, please ask the user to add the rate in CJAMS. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update alternateid (adoption_id) used for Payment generation tb_adoption
select adoptioncasenumber, alternateid, statustypekey, startdate, enddate, updatedby, updatedon 
	from adoptioncase 
where adoptioncasenumber = '231040250587'
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2023-08-23 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2037-05-11 00:00:00.000', -- 18th Birthday
	updatedby = 'CDM-36215',
	updatedon = now()
where adoptioncasenumber = '231040250587'
	and activeflag = 1 ;

-- Update Adopted Child Role 
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = 'f82e6598-da56-4a0b-aebc-1e721a6df729'
	and activeflag = 1 ;

Delete from adoptioncaseagreement where insertedby = 'CDM-36215';

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
	(	'e20ea328-b193-4f58-9169-5cafac443553', 1, '2023-03-21 04:00:00.000', 
		'2023-08-23 00:00:00.000', '2037-05-11 00:00:00.000', '2023-03-21 04:00:00.000',  NULL,
		'2023-03-21 04:00:00.000', '2023-03-21 04:00:00.000', '2023-03-21 04:00:00.000', 1,
		1, now(), 'CDM-36215',  now(), 'CDM-36215', now(),
		NULL, NULL, 6090786, 6090786, 'DAKIA MORGAN', 'HERMAN MORGAN',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, 'This is a child adopted by the Morgans through a private adoption agency', 'priaug', 'wtinst',
		'STAAA', 6090786, 614721, 614722 
	);
	
Delete from routing where insertedby = 'CDM-36215' and eventcode = 'ASAR';
	
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
	(	'ASAR', 'e30b7c99-a247-4d1b-80b3-6ab190fecc66', -- 	Aleata Dawkins
		'cc31ede-4dc7-446b-bc6d-fda4d8755cc2', -- Markeeta Dixon 
		'848bbdd0-0aef-4790-802d-e08275666fc2',  -- LDSS Management ,
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = 'e20ea328-b193-4f58-9169-5cafac443553' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-36215',  now(), 'CDM-36215', now(),
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 231040250587,
		NULL, NULL, NULL, NULL
	);	
		

-- Add Adoptive Parents
Delete from adoptioncaseactor where insertedby = 'CDM-36215' ;

-- Applicant: 200769956 (DAKIA MORGAN) - a30d6a8d-7483-479e-82f8-106757e7bb74
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), 'e20ea328-b193-4f58-9169-5cafac443553', 
		'e788beaa-883d-40e1-bd5c-d186ad5aeb9a', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-36215', now(), 'CDM-36215', NULL, NULL
	);
	
-- Co-Applicant: 3826598 (HERMAN MORGAN) - 43992de8-c7f8-4e48-b4d6-1893fc26cd04
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), 'e20ea328-b193-4f58-9169-5cafac443553', 
		'43992de8-c7f8-4e48-b4d6-1893fc26cd04', 'ADOPTIVEPARENT',
		1, now(), 'CDM-36215', now(), 'CDM-36215', NULL, NULL
	);