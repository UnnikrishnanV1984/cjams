/*
-- CDM-40214 - 

-- Issue Description: 
 Delete Living Arrangement

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set activeflag =0,updatedby ='CDM-40214',updatedon = now()
where placementid ='405618bc-d266-42ba-acbd-84f33c926fe9' and activeflag = 1;

update placementrevision 
set activeflag =0,updatedby ='CDM-40214',updatedon = now()
where placementid ='405618bc-d266-42ba-acbd-84f33c926fe9' and activeflag = 1;

update livingarrangement 
set activeflag =0,updatedby ='CDM-40214',updatedon = now()
where placementid ='405618bc-d266-42ba-acbd-84f33c926fe9' and activeflag = 1;

update routing  
set activeflag =0,updatedby ='CDM-40214',updatedon = now()
where objectid ='405618bc-d266-42ba-acbd-84f33c926fe9' and activeflag = 1;