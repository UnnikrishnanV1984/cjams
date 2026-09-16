/*
-- CDM-39666 - 

-- Issue Description: 
 Delete Living Arrangement
  
-- Customer Email ID: lisa.late@maryland.gov

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39666' 
where placementid in ('48b37322-3380-40d0-9ac7-92fda4af0db4','d4b1d247-923d-49a9-b87f-3803c9234b5e') and activeflag = 1;

update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39666'
where placementid in ('48b37322-3380-40d0-9ac7-92fda4af0db4','d4b1d247-923d-49a9-b87f-3803c9234b5e') and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39666' 
where placementid in ('48b37322-3380-40d0-9ac7-92fda4af0db4','d4b1d247-923d-49a9-b87f-3803c9234b5e') and activeflag = 1;

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39666'
where objectid  in ('48b37322-3380-40d0-9ac7-92fda4af0db4','d4b1d247-923d-49a9-b87f-3803c9234b5e') and activeflag = 1;