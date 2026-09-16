/*
-- CDM-19974 - 

-- Issue Description: 
 Delete Living Arrangement
  
-- Customer Email ID: kim.compton@maryland.gov

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-19974' 
where placementid in ('a125dfda-5df7-4e65-b461-6a9cc5319673','616e03e2-3138-4ea7-b1dc-5cd293e90495','0934807f-ec09-4c14-a0eb-6b58d3fb93e8','76ac04c8-2341-47d7-98c6-ef2ce33a1e59') and activeflag = 1;

update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-19974' 
where placementid in ('a125dfda-5df7-4e65-b461-6a9cc5319673','616e03e2-3138-4ea7-b1dc-5cd293e90495','0934807f-ec09-4c14-a0eb-6b58d3fb93e8','76ac04c8-2341-47d7-98c6-ef2ce33a1e59') and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-19974' 
where placementid in ('a125dfda-5df7-4e65-b461-6a9cc5319673','616e03e2-3138-4ea7-b1dc-5cd293e90495','0934807f-ec09-4c14-a0eb-6b58d3fb93e8','76ac04c8-2341-47d7-98c6-ef2ce33a1e59') and activeflag = 1;
