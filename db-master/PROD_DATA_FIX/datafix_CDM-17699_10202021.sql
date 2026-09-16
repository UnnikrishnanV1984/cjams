-- CDM-17699 - Unable to edit subsidy rate
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate End Date
   
-- Case ID: 3164267
-- Client ID: 2333748 (EXAVIER LOVE) - 9f255ccb-aa22-4550-b429-64be6e906bf6
-- Adoption ID: 18681 - 2008-06-03 To 2023-01-30 - 624c1c66-6bcd-4da1-b688-efe4ae1bc61b
-- Provider ID: 5005708 (April Love)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: Migrated Data issue (Rate Slab Start Date is 06/01/2009)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate End date as 10/15/2021 (Old value 2023-01-30)
select startdate, enddate, paymentamout, updatedby, updatedon 
	from adoptioncaseagreementrate 
where adoptionagreementid = 'b17958d5-3ff4-4fcd-99d1-de8eff1abde6'
	and adoptionagreementrateid = '6bcf795e-b182-40f5-936e-a8c612d541fe' 
	and activeflag = 1;

update adoptioncaseagreementrate
set enddate = '2021-10-15 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-17699'
where adoptionagreementid = 'b17958d5-3ff4-4fcd-99d1-de8eff1abde6'
	and adoptionagreementrateid = '6bcf795e-b182-40f5-936e-a8c612d541fe' 
	and activeflag = 1;


