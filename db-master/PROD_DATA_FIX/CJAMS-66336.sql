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



update investigationallegation set activeflag =0, updatedby ='CJAMS-66336', updatedon =now() 
where investigationallegationid ='d0425660-c2cd-483d-a007-15927119ac0f' and activeflag =1;
