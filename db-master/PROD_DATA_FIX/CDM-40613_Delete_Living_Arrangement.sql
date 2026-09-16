/*
Issue Description: CDM-40613
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: User requested for data delete.
-- Fix Provided: Datafix has been promoted to update the flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag =0, updatedby ='CDM-40613', updatedon =now()
where placementid = '72dc6305-bafd-4d0e-86b1-ad198397c081' and activeflag = 1;

update placementrevision 
set activeflag =0, updatedby ='CDM-40613', updatedon =now()
where placementid = '72dc6305-bafd-4d0e-86b1-ad198397c081' and activeflag = 1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-40613', updatedon =now()
where placementid = '72dc6305-bafd-4d0e-86b1-ad198397c081' and activeflag = 1;

update routing 
set activeflag =0, updatedby ='CDM-40613', updatedon =now()
where objectid = '72dc6305-bafd-4d0e-86b1-ad198397c081' and activeflag = 1;

