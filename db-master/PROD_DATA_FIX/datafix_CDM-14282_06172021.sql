-- CDM-14282 -- Pending Adoption
/*
-- Issue Description: 
   Adoption Case - Break the link error issue due to the duplicate subsidy rate slab.
   As requested this datafix is to remove the duplicate in-complete rate slab.

-- Case ID: 3148826
-- Client ID: 4199726 (LAYLA R STOUTER) 
  
-- Category/ Module: Adoption  (Adoption Case Management) 
-- Root cause: Data Issue (exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- 
*/

select status, activeflag, updatedby, updatedon
	from adoptionagreementraterevision 
where adoptionagreementid = '4e7d42ce-8cd7-4943-9c06-38ae693e3a4f'
	and adoptionagreementraterevisionid = 'eda202a8-2170-48c5-b90b-8866ce367398'
	and activeflag = 1 ;


update adoptionagreementraterevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-14282'
where adoptionagreementid = '4e7d42ce-8cd7-4943-9c06-38ae693e3a4f'
	and adoptionagreementraterevisionid = 'eda202a8-2170-48c5-b90b-8866ce367398'
	and activeflag = 1 ;

