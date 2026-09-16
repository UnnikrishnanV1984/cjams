/*

-- CDM-39635 - Placement
-- Issue Description:
-- Category/ Module: Placement
-- Fix Provided: Datafix to remove the duplicate living arrangement records
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where placementid ='13bbb598-58f2-420e-a5a7-d28c4004c50c' and activeflag =1;

update placementrevision 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where placementid ='13bbb598-58f2-420e-a5a7-d28c4004c50c' and activeflag =1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where placementid ='13bbb598-58f2-420e-a5a7-d28c4004c50c' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where objectid ='13bbb598-58f2-420e-a5a7-d28c4004c50c' and activeflag =1;