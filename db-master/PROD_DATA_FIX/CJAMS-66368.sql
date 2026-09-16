/*
-- Issue Description:
-- Category/ Module: Investigation Finding   
-- Root cause:  User request to Remove duplicated system error Investigation findings
--Fix provided: data fix has been done to remove the additional investigation findings
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update investigationallegation set activeflag =0, updatedby ='CJAMS-66368', updatedon =now() 
where investigationallegationid ='0d6c13ff-b97d-4f12-b39c-9f1150f8efbd' and activeflag =1;