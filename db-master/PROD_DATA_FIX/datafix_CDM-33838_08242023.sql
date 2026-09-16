-- CDM-33838 - Missing Subsidy Payment
/*
-- Issue Description: 
   Provider 6034037 is missing one month of Adoption subsidy payment.
   
-- Adoption Case ID: 231040082847
-- Client ID: 201173381 (Dillan Issac Wilkins) - f5daa620-d6bd-4e79-9526-0aa4082765d0
-- Adoption ID: 1058099 - 2023-03-17 To 2042-06-09 - 005b0419-ac13-4c31-8b12-28f095ff87eb
-- Provider ID: 6034037	(Lindsey Anne Wilkins)
-- Agreement:  de2446b8-59bd-48f2-96ae-3c964dca88a0	2023-02-15 To 2042-06-09
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: This is Provate Adoption case, this case was fixed with CDM-30868
		The adoptioncase table start date change was missed in that fix.
-- Fix Provided: Datafix has been promoted to fix the adoptioncase start date as 02/15/2023
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Adoption Case Start date (CDM-33838) (Old value 2023-03-17 09:59:00)
select alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncaseid = '005b0419-ac13-4c31-8b12-28f095ff87eb'
	and activeflag = 1;

update adoptioncase
set startdate = '2023-02-15 05:00:00',
	updatedon = now(), 
	updatedby = 'CDM-33838'
where adoptioncaseid = '005b0419-ac13-4c31-8b12-28f095ff87eb'
	and activeflag = 1;

-- To Trigger Under/Over 
select startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate
where adoptionagreementrateid  = '29c8f2a4-d6ba-4f70-826c-6c7cbbf8ab89'
	and adoptionagreementid  = 'de2446b8-59bd-48f2-96ae-3c964dca88a0'
	and activeflag = 1 ;
	
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-33838'
where adoptionagreementrateid  = '29c8f2a4-d6ba-4f70-826c-6c7cbbf8ab89'
	and adoptionagreementid  = 'de2446b8-59bd-48f2-96ae-3c964dca88a0'
	and activeflag = 1 ;

