-- CDM-13250 - Remove subsidy renewal
/*
-- Issue Description: 
   This request is to remove the most recent un-approved rate slab
   
-- Case ID: 3172546 - rhonda.gardner@maryland.gov
-- Client ID: 2586196 (MALIK KWAME COSSEY) - a6ad5308-db17-447b-a442-2209cacd74bf
-- Adoption ID: 20663 - 2009-04-01 to 2021-12-31 - 732af0a9-2da4-49ab-a3de-23aeb83d1f5f
-- Rate Slab: 2021-03-11 to 2021-12-31 - $835 - Review - 5e93c771-143c-44b7-8a98-da380ae1e4e4

-- Category/ Module: Adoption Subsidy (Adoption Case Management) 
-- Root cause: Exception scenario, user wants to transfer the Adoption to 2nd parent. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select adoptionrevisionid, startdate, enddate, paymentamout, status, activeflag, updatedby, updatedon 
	from adoptioncaserevision  
where adoptionrevisionid = '5e93c771-143c-44b7-8a98-da380ae1e4e4'
	and activeflag  = 1 ;

update adoptioncaserevision  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-13250'
where adoptionrevisionid = '5e93c771-143c-44b7-8a98-da380ae1e4e4'
	and activeflag  = 1 ;
	
