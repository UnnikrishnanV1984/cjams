-- CDM-30629 - Correcting adoption subsidy date
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Start Date
   
-- Adoption Case ID: 231040103625
-- Adoption ID: 1051256 - 2023-04-12 To 2024-04-11 - 1b6de5f2-9d90-425a-a009-fddccf1996bc 
-- Provider ID: 5092382	(Terry  Ogburn)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Data issue (Date change was missed in prior ticket CDM-4371)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Adoption Subsidy 2023-04-06 To 2024-04-05 (Old 2023-04-12 To 2024-04-11) 
-- Rate 2023-04-06  To 2022-05-20 (Old 2021-07-26 To 2022-07-25)

-- Bio Case Side(3297580)
-- 2023-04-06  To 2024-04-05 (Old 2023-04-12 To 2024-04-11)
select startdate, enddate, updatedby, updatedon 
	from adoptionagreement 
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

update adoptionagreement
set startdate = '2023-04-06 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

select startdate, enddate, updatedby, updatedon 
	from adoptionagreementrevision  
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

update adoptionagreementrevision
set startdate = '2023-04-06 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

-- 2021-05-21 To 2022-05-20 (Old 2021-07-26 To 2022-07-25)
select startdate, enddate, updatedby, updatedon
	from adoptionagreementrate 
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

update adoptionagreementrate
set startdate = '2023-04-06 16:41:55',	
	enddate = '2024-04-05 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

select startdate, enddate, updatedby, updatedon 
	from adoptionagreementraterevision 
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;

update adoptionagreementraterevision
set startdate = '2023-04-06 16:41:55',	
	enddate = '2024-04-05 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptionagreementid = '6d8b9375-26a0-4ef5-a0a3-cacda330f0e5' ;


-- Adoption Case Side
-- 2021-05-21 To 2024-04-05 (Old 2023-04-12 To 2024-04-11)
select startdate, enddate, updatedby, updatedon 
	from adoptioncase 
where adoptioncaseid = '1b6de5f2-9d90-425a-a009-fddccf1996bc' ;

update adoptioncase
set startdate = '2023-04-06 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptioncaseid = '1b6de5f2-9d90-425a-a009-fddccf1996bc' ;

select startdate, enddate, updatedby, updatedon
	from adoptioncaseagreement 
where adoptioncaseid = '1b6de5f2-9d90-425a-a009-fddccf1996bc' ;

update adoptioncaseagreement
set startdate = '2023-04-06 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptioncaseid = '1b6de5f2-9d90-425a-a009-fddccf1996bc' ;

-- 2021-05-21 To 2022-05-20 (Old 2021-07-26 To 2022-07-25)
select startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate 
where adoptionagreementid = 'a6376528-5ad2-434a-b931-29fcf97a13fc' ;

update adoptioncaseagreementrate
set startdate = '2023-04-06 16:41:55',	
	enddate = '2024-04-05 16:41:55',
	updatedon = now(), 
	updatedby = 'CDM-30629'
where adoptionagreementid = 'a6376528-5ad2-434a-b931-29fcf97a13fc' ;

