/*

-- CDM-39767 - Placement
-- Issue Description:
-- Category/ Module: Placement
-- Fix Provided: Datafix to remove the rejected living arrangement records.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set activeflag =0, updatedby ='CDM-39767', updatedon =now()
where placementid ='dd1a6df3-2ee7-4ddc-9e29-f05249652761' and activeflag =1;


update placementrevision 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where placementid ='dd1a6df3-2ee7-4ddc-9e29-f05249652761' and activeflag =1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where placementid ='dd1a6df3-2ee7-4ddc-9e29-f05249652761' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-39635', updatedon =now()
where objectid ='dd1a6df3-2ee7-4ddc-9e29-f05249652761' and activeflag =1;

