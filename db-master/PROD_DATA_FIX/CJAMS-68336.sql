/*
-- Issue Description:
-- Category/ Module: Investigation Finding   
-- Root cause:  User request to Remove duplicated system error Investigation findings
--Fix provided: data fix has been done to remove the additional investigation findings
--Is code fix required: Yes CIDM-11232
-- Pull request :
-- Reason why no related code fix: code fix ticket has been raised 
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update investigationallegation set activeflag =0, updatedby ='CJAMS-68336', updatedon =now() 
where investigationallegationid ='4e6c660f-d273-4b26-8065-6480b5c223f7' and activeflag =1;