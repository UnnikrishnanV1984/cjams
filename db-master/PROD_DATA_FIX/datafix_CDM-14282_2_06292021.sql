-- CDM-14282 -- Pending Adoption
/*
-- Issue Description: 
   Adoption Case - Break the link error issue due to the duplicate subsidy rate slab.
   
-- Case ID: 3148826
-- Client ID: 4199726 (LAYLA R STOUTER) 
  
-- Category/ Module: Adoption  (Adoption Case Management) 
-- Root cause: Data Issue (exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/

-- Datafix is to remove the 2 duplicate Adoption Agreements
select adoptionagreementid, activeflag, updatedby, updatedon 
	from adoptionagreement 
where adoptionplanningid  = 'a0cce625-11b2-4231-85fe-d356274b5ef4'
	and adoptionagreementid <> '4e7d42ce-8cd7-4943-9c06-38ae693e3a4f'
	and activeflag = 1 ;

update adoptionagreement
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-14282_2'
where adoptionplanningid  = 'a0cce625-11b2-4231-85fe-d356274b5ef4'
	and adoptionagreementid <> '4e7d42ce-8cd7-4943-9c06-38ae693e3a4f'
	and activeflag = 1 ;
