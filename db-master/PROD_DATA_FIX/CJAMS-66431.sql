/*
-- Issue Description:
-- Category/ Module: Investigation Finding   
-- Root cause:  User request to Remove duplicated system error Investigation findings
--Fix provided: data fix has been done to remove the additional investigation findings
--Is code fix required: Yes
-- Pull request :
-- Reason why no related code fix: Issue is not replicable in stage3, code fix ticket has been raised 
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update investigationallegation set activeflag =0, updatedby ='CJAMS-66431', updatedon =now() 
where investigationallegationid ='2fc1ae7c-b975-4158-9c7e-6123c2d96470' and activeflag =1;