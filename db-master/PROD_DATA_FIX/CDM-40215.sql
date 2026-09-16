/*
Issue Description: CDM-40215
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: User requested for data delete.
-- Fix Provided: Datafix has been promoted to update the flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag =0, updatedby ='CDM-40215', updatedon =now()
where placementid = 'c06a4dd2-84b4-49d3-ab4c-15b111cca912' and activeflag = 1;

update placementrevision 
set activeflag =0, updatedby ='CDM-40215', updatedon =now()
where placementid = 'c06a4dd2-84b4-49d3-ab4c-15b111cca912' and activeflag = 1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-40215', updatedon =now()
where placementid = 'c06a4dd2-84b4-49d3-ab4c-15b111cca912' and activeflag = 1;

update routing 
set activeflag =0, updatedby ='CDM-40215', updatedon =now()
where objectid = 'c06a4dd2-84b4-49d3-ab4c-15b111cca912' and activeflag = 1;
