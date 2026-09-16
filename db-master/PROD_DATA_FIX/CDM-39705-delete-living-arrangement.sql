/*
-- CDM-39705 - 

-- Issue Description: 
 Delete Living Arrangement
  
-- Customer Email ID: megan.murphy@maryland.gov

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39705' 
where placementid= 'a00de59a-3c41-4fa9-9991-e50a9b723c56' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39705'
where placementid= 'a00de59a-3c41-4fa9-9991-e50a9b723c56' and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39705' 
where placementid= 'a00de59a-3c41-4fa9-9991-e50a9b723c56' and activeflag = 1;

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-39666'
where objectid= 'a00de59a-3c41-4fa9-9991-e50a9b723c56' and activeflag = 1;