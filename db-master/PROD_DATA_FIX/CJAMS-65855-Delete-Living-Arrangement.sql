/*
-- CJAMS-65855

-- Issue Description: 
 Delete Living Arrangement

-- Root cause: Data fix to set the active flag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement 
set activeflag =0,updatedby ='CJAMS-65855',updatedon = now()
where placementid ='636f29ac-7876-4919-bce1-54e9a8baf3e6' and activeflag = 1;

update placementrevision 
set activeflag =0,updatedby ='CJAMS-65855',updatedon = now()
where placementid ='636f29ac-7876-4919-bce1-54e9a8baf3e6' and activeflag = 1;

update livingarrangement 
set activeflag =0,updatedby ='CJAMS-65855',updatedon = now()
where placementid ='636f29ac-7876-4919-bce1-54e9a8baf3e6' and activeflag = 1;

update routing  
set activeflag =0,updatedby ='CJAMS-65855',updatedon = now()
where objectid ='636f29ac-7876-4919-bce1-54e9a8baf3e6' and activeflag = 1;