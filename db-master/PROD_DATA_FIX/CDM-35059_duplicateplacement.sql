-- CDM-35059 - Placement
/*
-- Issue Description:
-- Category/ Module: Placement
-- Fix Provided: Datafix to remove the duplicate living arrangement records
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE livingarrangement 
SET activeflag = 0, updatedby = 'CDM-35059', updatedon = now() 
WHERE livingid in ('3a8feb63-3125-4392-bda2-8cd7a49002dc','a5f22d0b-4959-4ee8-966f-0d60418a3cf2','dcf77a01-5863-4a0a-ac40-5b497e6951f9')
and placementid in ('17eb25aa-b1ee-4fb2-899d-44ff60fb8fd8','7b9fcd10-40b9-4d7f-afe6-d94db817f74c','91676535-6d66-488a-91c5-d36c27c43bed')
and activeflag = 1;

update placement 
SET activeflag = 0, updatedby = 'CDM-35059', updatedon = now() 
WHERE placementid in ('17eb25aa-b1ee-4fb2-899d-44ff60fb8fd8','7b9fcd10-40b9-4d7f-afe6-d94db817f74c','91676535-6d66-488a-91c5-d36c27c43bed')
and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CDM-35059', updatedon = now() 
where objectid in ('17eb25aa-b1ee-4fb2-899d-44ff60fb8fd8','7b9fcd10-40b9-4d7f-afe6-d94db817f74c','91676535-6d66-488a-91c5-d36c27c43bed')
and activeflag = 1;

