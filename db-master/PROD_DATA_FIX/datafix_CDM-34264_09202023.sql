-- CDM-34264 - Private Adoption Subsidy Data Entry Issue
/*
-- Issue Description: 
   Private adoption case data issue 
      
-- Adoption Case ID: 231040181758 - 1be45fb6-e1f1-48d7-9c1f-f1ce3853ad68
-- Client ID: 201773673 (Sevaughn Cooper) - 99b30260-2332-4530-893b-eb0aee929ac5
-- Provider ID: 6072551	(MAVRYN LYNN COOPER) - Local Department Home
-- Applicant: 3716265 (MAVRYN LYNN COOPER) - a30d6a8d-7483-479e-82f8-106757e7bb74
-- Co-Applicant: 3716267 (BRYCE	ADAM COOPER) - b5c885e5-ee9c-4a71-b468-e13e1a7e2d91


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
where adoptioncasenumber = '231040181758'
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2023-08-08 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2032-12-01 00:00:00.000',
	updatedby = 'CDM-34264',
	updatedon = now()
where adoptioncasenumber = '231040181758'
	and activeflag = 1 ;

-- Update Adopted Child Role 
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = '7833cb76-b0f4-405f-bebe-63ea2eab1a4c'
	and activeflag = 1 ;

update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-34264' 
where adoptioncaseactorid  = '7833cb76-b0f4-405f-bebe-63ea2eab1a4c'
	and activeflag = 1 ;

Delete from adoptioncaseagreement where insertedby = 'CDM-34264';

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
	(	'1be45fb6-e1f1-48d7-9c1f-f1ce3853ad68', 1, '2023-08-08 04:00:00.000', 
		'2023-08-08 00:00:00.000', '2032-12-01 00:00:00.000', '2023-08-08 04:00:00.000',  NULL,
		'2023-04-14 04:00:00.000', '2023-04-14 04:00:00.000', '2023-04-14 04:00:00.000', 1,
		1, now(), 'CDM-34264',  now(), 'CDM-34264', now(),
		NULL, NULL, 6072551, 6072551, 'MAVRYN LYNN COOPER', 'BRYCE	ADAM COOPER',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, NULL, 'iveag', 'wtinst',
		'TIAAA', 6072551, 591530, 591531
	);
	
Delete from routing where insertedby = 'CDM-34264' and eventcode = 'ASAR';
	
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
	(	'ASAR', '169264bc-38d0-4925-9623-fb14dea8a599', -- 	Nathaniel Parks
		'27920e1e-978e-4231-a9d5-ea7323ceb413', -- Bradley Wofford 
		'f8348f64-e5d4-4ee9-8cf4-2fe3627446fb',  -- Adoptions ,
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '1be45fb6-e1f1-48d7-9c1f-f1ce3853ad68' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-34264',  now(), 'CDM-34264', now(),
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 231040181758,
		NULL, NULL, NULL, NULL
	);	
		

-- Add Adoptive Parents
Delete from adoptioncaseactor where insertedby = 'CDM-34264' ;

-- Applicant: 3716265 (MAVRYN LYNN COOPER) - a30d6a8d-7483-479e-82f8-106757e7bb74
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '1be45fb6-e1f1-48d7-9c1f-f1ce3853ad68', 
		'a30d6a8d-7483-479e-82f8-106757e7bb74', 'ADOPTIVEPARENT', 
		1, now(), 'CDM-34264', now(), 'CDM-34264', NULL, NULL
	);
	
-- Co-Applicant: 3716267 (BRYCE	ADAM COOPER) - b5c885e5-ee9c-4a71-b468-e13e1a7e2d91
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, actortypekey,
		activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '1be45fb6-e1f1-48d7-9c1f-f1ce3853ad68', 
		'b5c885e5-ee9c-4a71-b468-e13e1a7e2d91', 'ADOPTIVEPARENT',
		1, now(), 'CDM-34264', now(), 'CDM-34264', NULL, NULL
	);