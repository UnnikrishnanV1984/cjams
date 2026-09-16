-- CDM-37268 - Subsidy Screen Approval for Veranika Miller
/*
-- Issue Description: 
   Private adoption case data issue 
      
-- Adoption Case ID: 231040234110 - 707ff7d9-d8e3-420a-8738-30f991c1a979
-- Client ID: 202304872 (Veranika Miller) - 9d8b6d66-5061-4cab-a9d5-b5bb5c0727b8
-- Provider ID: 6103436	(RYAN MILLER) - Local Department Home
-- Applicant: 4079120 (RYAN MILLER) - 0b39de71-6a53-4f74-a061-78fe8ffd0d22
-- Co-Applicant: 4079231 (KARI-ANN MILLER) - ab1c538d-92e4-4831-a853-0f2609a1e3a2


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
where adoptioncasenumber = '231040234110'
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	statustypekey = 'Open',
	startdate = '2020-05-18 00:00:00.000', -- Subsidy start date confirmed by the user
	enddate = '2037-04-01 00:00:00.000', -- 18th Birthday
	updatedby = 'CDM-37268',
	updatedon = now()
where adoptioncasenumber = '231040234110'
	and activeflag = 1 ;


-- To find adoptive parent ids
SELECT * FROM prov.tb_prov_approval_person 
	WHERE provider_approval_id IN (SELECT TBA.provider_approval_id 
										FROM tb_provider_approval TBA 
										WHERE TBA.provider_id = 6103436
											AND TBA.active_sw = 'Y' 
											AND DELETE_SW = 'N'
										ORDER BY TBA.approval_dt desc limit 1);


Delete from adoptioncaseagreement where insertedby = 'CDM-37268';

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
	(	'707ff7d9-d8e3-420a-8738-30f991c1a979', 1, '2020-03-27 10:00:00.000', 
		'2020-05-18 00:00:00.000', '2037-04-01 00:00:00.000', '2020-03-20 10:00:00.000',  NULL,
		'2020-03-20 10:00:00.000', '2020-03-20 10:00:00.000', '2020-03-27 10:00:00.000', 0,
		1, now(), 'CDM-37268',  now(), 'CDM-37268', now(),
		NULL, NULL, 6103436, 6103436, 'RYAN MILLER', 'KARI-ANN MILLER',
		nextval('sequence_adoptionagreement'::regclass), NULL, NULL, NULL,
		NULL, NULL, 'Adoption Finalized in Baltimore County Circuit Court on May 18, 2020. Veranika has a genetic diagnosis of down syndrome.', 'priaug', 'wtinst',
		'TIAAA', 6103436, 624139, 624140 
	);
	
Delete from routing where insertedby = 'CDM-37268' and eventcode = 'ASAR';
	
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
	(	'ASAR', '9208693f-7cdf-45ae-983b-e4eaa0a3cb7c', -- 	Zelda Olarewaju
		'07a6565f-428d-473d-93c5-a7d20a42ad0f', -- Tiffany Stancil 
		'af5e6b9a-2178-4bae-b14e-1776c20659ab',  -- Family Support Services #1 ,
		'CWSP', 'CWCW', 
		(select adoptionagreementid 
			from adoptioncaseagreement 
		where adoptioncaseid = '707ff7d9-d8e3-420a-8738-30f991c1a979' 
			and activeflag = 1
		order by insertedon desc
		limit 1		
		),
		16, 1, 'CDM-37268',  '2024-02-13 10:00:00.000', 'CDM-37268', '2024-02-13 10:00:00.000',
		True, 'Adoption Agreement Approved', NULL, 'Adoption Agreement Approved', 231040234110,
		NULL, NULL, NULL, NULL
	);	
	
-- Update Adopted Child Role 
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = '39e8f045-72bb-4a2b-ad0e-6fb508d87e3d'
	and activeflag = 1 ;	
		
update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CDM-37268' 
where adoptioncaseactorid  = '39e8f045-72bb-4a2b-ad0e-6fb508d87e3d'
	and activeflag = 1 ;
	
-- Add Adoptive Parents
Delete from adoptioncaseactor where insertedby = 'CDM-37268' ;

-- Adoptive Parent1: RYAN MILLER (Provider # 6103436; PID# 4079120)
-- Adoptive Parent2: KARI-ANN MILLER ( PID# 4079231) 

	
INSERT INTO cjams.adoptioncaseactor
( adoptioncaseid, personid, actortypekey, old_id, activeflag, insertedon, insertedby, updatedon, updatedby)
values
( '707ff7d9-d8e3-420a-8738-30f991c1a979', (select personid from person where cjamspid = '4079120'), 'ADOPTIVEPARENT', '231040234110', 1, now(), 'CDM-37268', now(), 'CDM-37268'),
( '707ff7d9-d8e3-420a-8738-30f991c1a979', (select personid from person where cjamspid = '4079231'), 'ADOPTIVEPARENT', '231040234110', 1, now(), 'CDM-37268', now(), 'CDM-37268');