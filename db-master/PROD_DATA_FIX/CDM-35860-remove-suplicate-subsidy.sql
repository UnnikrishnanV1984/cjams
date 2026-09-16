-- CDM-3586 -- Pending Adoption
/*
-- Issue Description: 
   Adoption Case - Break the link error issue due to the duplicate subsidy rate slab.
   As requested this datafix is to remove the duplicate in-complete rate slab.

-- Case ID: 3307172
  
-- Category/ Module: Adoption  (Adoption Case Management) 
-- Root cause: Data Issue (exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- 
*/
select * from adoptionagreement
where adoptionagreementid = '3223fb89-eb44-4306-8b7f-73a408c132f3' and activeflag = 1;
	
update adoptionagreement set activeflag = 0, updatedby = 'CDM-35860', updatedon = now()
where adoptionagreementid = '3223fb89-eb44-4306-8b7f-73a408c132f3' and activeflag = 1;