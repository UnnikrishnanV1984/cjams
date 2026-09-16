-- CDM-32077 - IN CORRECT DOB
/*
-- Issue Description: 
	User Error - Client's date of birth was changed caused the subsidy to stop paying  
   
-- Adoption Case ID: 3189416
-- Client ID: 3108937 (MAKAYLA QUEN	MANSON) - 3da4c1b0-f6e2-437b-992f-4740ae5dd2cc
-- DOB: 04/25/2006 (Wrong Value 04/25/1901)
-- Adoption ID: 26943 - 2010-07-20 To 2024-04-25 - af05cda6-3d99-49f2-a9c0-19a73edb21af
-- Provider ID: 5003637	(Wanda Manson)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to trigger Under/Over batch for missing May 2023 payment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under Over batch 
select startdate, enddate, paymentamout, status, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '24557fac-2caa-4c21-ac13-585bc52e118c'
  and activeflag = 1 ;

update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-32077'
where adoptionagreementrateid = '24557fac-2caa-4c21-ac13-585bc52e118c'
  and activeflag = 1 ;
