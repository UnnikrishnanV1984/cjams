/*
Issue Description: CDM-39945
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to update the flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag =0, updatedby ='CDM-39945', updatedon =now()
where placementid in ('40c1537c-7c1f-4d4d-a424-6979813a39cf','41442bca-ade5-441a-a233-1b948e9bf24f') and activeflag =1;

update placementrevision 
set activeflag =0, updatedby ='CDM-39945', updatedon =now()
where placementid in ('40c1537c-7c1f-4d4d-a424-6979813a39cf','41442bca-ade5-441a-a233-1b948e9bf24f') and activeflag =1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-39945', updatedon =now()
where placementid in ('40c1537c-7c1f-4d4d-a424-6979813a39cf','41442bca-ade5-441a-a233-1b948e9bf24f') and activeflag =1;

update routing 
set activeflag =0, updatedby ='CDM-39945', updatedon =now()
where objectid in ('40c1537c-7c1f-4d4d-a424-6979813a39cf','41442bca-ade5-441a-a233-1b948e9bf24f') and activeflag =1;