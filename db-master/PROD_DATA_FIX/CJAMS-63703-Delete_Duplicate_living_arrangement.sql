/*
-- CJAMS-63703 - 

-- Issue Description: 
 Delete Living Arrangement

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set activeflag =0,updatedby ='CJAMS-63703',updatedon = now()
where placementid ='44054976-8a1b-4f0b-a56c-34996ab799f3' and activeflag = 1;

update placementrevision 
set activeflag =0,updatedby ='CJAMS-63703',updatedon = now()
where placementid ='44054976-8a1b-4f0b-a56c-34996ab799f3' and activeflag = 1;

update livingarrangement 
set activeflag =0,updatedby ='CJAMS-63703',updatedon = now()
where placementid ='44054976-8a1b-4f0b-a56c-34996ab799f3' and activeflag = 1;

update routing  
set activeflag =0,updatedby ='CJAMS-63703',updatedon = now()
where objectid ='44054976-8a1b-4f0b-a56c-34996ab799f3' and activeflag = 1;