-- CDM-12443 - Adoption Subsidy
/*
-- Issue Description: 
	Adoption Case # 3308072 - Short Payment Issue for July 2020 service month
   
	Adoption Case ID: 3308072 - eva.hall@maryland.gov
	Client ID: 4495836 (LUTREAL D HATHWAY) - 2e454e86-a160-4e43-9eaa-31c99cdbf31d 
	Adoption ID: 51458 - 2020-07-03 to 2034-06-20 - e49c91d9-888e-4353-9810-c43e6f586484
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Data issue (Date change was missed in prior ticket CDM-4371)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Adoption Case Start Date as 2020-07-01 (old Value was 2020-07-03)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid ='e49c91d9-888e-4353-9810-c43e6f586484'
	and activeflag = 1;

update adoptioncase
set startdate = '2020-07-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12443'
where adoptioncaseid = 'e49c91d9-888e-4353-9810-c43e6f586484'
	and activeflag = 1;

-- To Trigger Under/Over 
select startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate
where adoptionagreementrateid = '5676ed32-604d-4a16-9f43-1a742c6deef2'
	and adoptionagreementid = '565f143e-4ef6-47c2-8f8f-313f80aeb09a'
	and activeflag = 1 ;
	
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-12443'
where adoptionagreementrateid = '5676ed32-604d-4a16-9f43-1a742c6deef2'
	and adoptionagreementid = '565f143e-4ef6-47c2-8f8f-313f80aeb09a'
	and activeflag = 1 ;
	