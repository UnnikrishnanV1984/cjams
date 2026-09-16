-- CDM-18461 - Subsidy Rate
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate Start Date
   
-- Adoption Case ID: 3186231
-- Client ID: 3029112 (DEREK JAKE KEYES) - 4c93a066-842a-4e21-aad7-4172b23c045a
-- Adoption ID: 25623 - 04/21/2010 To 12/25/2022 - db0a6209-0734-4158-869a-dc23e674b964
-- Provider ID: 5042957	(Sherrod  Keyes) 
-- Current Rate slab: 08/31/2022 To 08/31/2022 - $835 - 0c2c7d6f-aacc-436c-8d54-7f8a35d5b2f5
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate Start date as 09/01/2021 (Old value 08/31/2022)
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '15d43859-afaf-47e2-b474-427fb91045f3'
	and adoptionagreementrateid = '0c2c7d6f-aacc-436c-8d54-7f8a35d5b2f5' ;

update adoptioncaseagreementrate
set startdate = '2021-09-01 04:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18461'
where adoptionagreementid = '15d43859-afaf-47e2-b474-427fb91045f3'
	and adoptionagreementrateid = '0c2c7d6f-aacc-436c-8d54-7f8a35d5b2f5' ;

select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '15d43859-afaf-47e2-b474-427fb91045f3'
	and adoptionagreementrateid = '0c2c7d6f-aacc-436c-8d54-7f8a35d5b2f5' ;

update adoptioncaserevision
set startdate = '2021-09-01 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-18461'
where adoptionagreementid = '15d43859-afaf-47e2-b474-427fb91045f3'
	and adoptionagreementrateid = '0c2c7d6f-aacc-436c-8d54-7f8a35d5b2f5' ;

update adoptioncaserevision
set approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-18461'
where adoptionagreementid = '15d43859-afaf-47e2-b474-427fb91045f3'
	and adoptionagreementrateid = '0c2c7d6f-aacc-436c-8d54-7f8a35d5b2f5'
	and approvaldate is not null ;
