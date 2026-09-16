
/*
Issue Description: CDM-40614
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: User requested for data delete.
-- Fix Provided: Datafix has been promoted to update the flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update placement 
set activeflag =0, updatedby ='CDM-40614', updatedon =now()
where placementid = '0ebcf4fe-6105-4d9c-8842-37750be51b1c' and activeflag = 1;

update placementrevision 
set activeflag =0, updatedby ='CDM-40614', updatedon =now()
where placementid = '0ebcf4fe-6105-4d9c-8842-37750be51b1c' and activeflag = 1;

update livingarrangement 
set activeflag =0, updatedby ='CDM-40614', updatedon =now()
where placementid = '0ebcf4fe-6105-4d9c-8842-37750be51b1c' and activeflag = 1;

update routing 
set activeflag =0, updatedby ='CDM-40614', updatedon =now()
where objectid = '0ebcf4fe-6105-4d9c-8842-37750be51b1c' and activeflag = 1;
