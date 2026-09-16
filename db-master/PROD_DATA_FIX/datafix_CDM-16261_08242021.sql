-- CDM-16261 - Correcting adoption subsidy date
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Start Date
   
-- Adoption Case ID: 211040009646
-- Adoption ID: 1051256 - 2021-07-26 To 2034-06-09 - 09d5979d-9337-4b20-862b-bffbc139b1cf 
-- Provider ID: 5092382	(Terry  Ogburn)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Data issue (Date change was missed in prior ticket CDM-4371)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Adoption Subsidy 2021-05-21 To 2034-06-09 (Old 2021-07-26 To 2034-06-09) 
-- Rate 2021-05-21 To 2022-05-20 (Old 2021-07-26 To 2022-07-25)

-- Bio Case Side
-- 2021-05-21 To 2034-06-09 (Old 2021-07-26 To 2034-06-09)
select startdate, enddate, updatedby, updatedon 
	from adoptionagreement 
where adoptionplanningid = '1c436a77-738f-4f75-82a3-603a7f76c281' ;

update adoptionagreement
set startdate = '2021-05-21 18:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptionplanningid = '1c436a77-738f-4f75-82a3-603a7f76c281' ;

select startdate, enddate, updatedby, updatedon 
	from adoptionagreementrevision  
where adoptionagreementid = '57dd6f4d-016f-4c97-be0d-4d7a48528555' ;

update adoptionagreementrevision
set startdate = '2021-05-21 18:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptionagreementid = '57dd6f4d-016f-4c97-be0d-4d7a48528555' ;

-- 2021-05-21 To 2022-05-20 (Old 2021-07-26 To 2022-07-25)
select startdate, enddate, updatedby, updatedon
	from adoptionagreementrate 
where adoptionagreementid = '57dd6f4d-016f-4c97-be0d-4d7a48528555' ;

update adoptionagreementrate
set startdate = '2021-05-21 18:23:02',	
	enddate = '2022-05-20 22:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptionagreementid = '57dd6f4d-016f-4c97-be0d-4d7a48528555' ;

select startdate, enddate, updatedby, updatedon 
	from adoptionagreementraterevision 
where adoptionagreementid = '57dd6f4d-016f-4c97-be0d-4d7a48528555' ;

update adoptionagreementraterevision
set startdate = '2021-05-21 18:23:02',	
	enddate = '2022-05-20 22:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptionagreementid = '57dd6f4d-016f-4c97-be0d-4d7a48528555' ;


-- Adoption Case Side
-- 2021-05-21 To 2034-06-09 (Old 2021-07-26 To 2034-06-09)
select startdate, enddate, updatedby, updatedon 
	from adoptioncase 
where adoptioncaseid = '09d5979d-9337-4b20-862b-bffbc139b1cf' ;

update adoptioncase
set startdate = '2021-05-21 18:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptioncaseid = '09d5979d-9337-4b20-862b-bffbc139b1cf' ;

select startdate, enddate, updatedby, updatedon
	from adoptioncaseagreement 
where adoptioncaseid = '09d5979d-9337-4b20-862b-bffbc139b1cf' ;

update adoptioncaseagreement
set startdate = '2021-05-21 18:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptioncaseid = '09d5979d-9337-4b20-862b-bffbc139b1cf' ;

-- 2021-05-21 To 2022-05-20 (Old 2021-07-26 To 2022-07-25)
select startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate 
where adoptionagreementid = '33b8154a-132b-48b3-a303-d8776e28e1e6' ;

update adoptioncaseagreementrate
set startdate = '2021-05-21 18:23:02',	
	enddate = '2022-05-20 22:23:02',
	updatedon = now(), 
	updatedby = 'CDM-16261'
where adoptionagreementid = '33b8154a-132b-48b3-a303-d8776e28e1e6' ;

