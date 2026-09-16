/*
-- CDM-40191 - 

-- Issue Description: 
 Delete Living Arrangement
-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement
set activeflag=0, updatedby='CDM-40191',updatedon=now()
where placementid='d19019ef-0d5f-405b-97d8-dad0d6161d81' and personid='57271c90-7274-4c08-b524-69b83448f27b' and activeflag=1;

update placementrevision
set activeflag=0, updatedby='CDM-40191',updatedon=now()
where placementid='d19019ef-0d5f-405b-97d8-dad0d6161d81' and activeflag=1;

update livingarrangement
set activeflag=0, updatedby='CDM-40191',updatedon=now()
where placementid='d19019ef-0d5f-405b-97d8-dad0d6161d81' and activeflag=1;

update routing
set activeflag=0, updatedby='CDM-40191',updatedon=now()
where objectid='d19019ef-0d5f-405b-97d8-dad0d6161d81' and activeflag=1;