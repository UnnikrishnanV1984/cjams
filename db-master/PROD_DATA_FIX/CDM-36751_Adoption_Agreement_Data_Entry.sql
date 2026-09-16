-- CDM-36751 - Private Adoption Subsidy Data Entry Issue
/*
-- Issue Description: 
   Private adoption case data issue 
      
-- Adoption Case ID: 241040264725 - 0496332e-fe2f-4ae3-904b-599ebe0a57fe
-- Client ID: 202564648 (Kaiyanna Morgan) - 47864731-7436-42b9-9795-44a272988b8a
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
where adoptioncasenumber = '241040264725'
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2023-08-23 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2037-05-11 00:00:00.000', -- 18th Birthday
	updatedby = 'CDM-36751',
	updatedon = now()
where adoptioncasenumber = '241040264725'
	and activeflag = 1 ;

-- Update Adopted Child Role 
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = 'f8a4f90a-c0cf-45df-8e5d-4217af73a582'
	and activeflag = 1 ;

Delete from adoptioncaseagreement where insertedby = 'CDM-36751';

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
	(	'0496332e-fe2f-4ae3-904b-599ebe0a57fe', 1, '2023-03-21 10:00:00.000', 
		'2023-08-23 00:00:00.000', '2037-05-11 00:00:00.000', '2023-03-21 10:00:00.000',  NULL,
		'2023-03-21 10:00:00.000', '2023-03-21 10:00:00.000', '2023-03-21 10:00:00.000', 1,
		1, now(), 'CDM-36751',  now(), 'CDM-36751', now(),
		NULL, NULL, 6090786, 6090786, 'DAKIA MORGAN', 'HERMAN MORGAN',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, 'This is a child adopted by the Morgans through a private adoption agency', 'priaug', 'wtinst',
		'STAAA', 6090786, 614721, 614722 
	);
	
Delete from routing where insertedby = 'CDM-36751' and eventcode = 'ASAR';
	
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
		where adoptioncaseid = '0496332e-fe2f-4ae3-904b-599ebe0a57fe' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-36751',  now(), 'CDM-36751', now(),
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 241040264725,
		NULL, NULL, NULL, NULL
	);	
		
update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-36751' 
where adoptioncaseactorid  = 'f8a4f90a-c0cf-45df-8e5d-4217af73a582'
	and activeflag = 1 ;
	
-- Add Adoptive Parents
Delete from adoptioncaseactor where insertedby = 'CDM-36751' ;

-- Adoptive Parent1: Dakia Morgan (Provider # 6090786; PID# 200769956)
-- Adoptive Parent2: Herman Morgan ( PID# 3826598) 

	
INSERT INTO cjams.adoptioncaseactor
( adoptioncaseid, personid, actortypekey, old_id, activeflag, insertedon, insertedby, updatedon, updatedby)
values
( '0496332e-fe2f-4ae3-904b-599ebe0a57fe', (select personid from person where cjamspid = '200769956'), 'ADOPTIVEPARENT', '241040264725', 1, now(), 'CDM-36751', now(), 'CDM-36751'),
( '0496332e-fe2f-4ae3-904b-599ebe0a57fe', (select personid from person where cjamspid = '3826598'), 'ADOPTIVEPARENT', '241040264725', 1, now(), 'CDM-36751', now(), 'CDM-36751');
