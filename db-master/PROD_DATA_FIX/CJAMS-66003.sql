/*
-- Issue Description:
-- Category/ Module: Inverstigation Finding   
-- Root cause:  User request to Remove duplicated system error Investigation findings
--Fix provided: data fix has been done to remove the additional investigation findings
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update investigationallegation set activeflag =0, updatedby ='CJAMS-66003', updatedon =now() 
where investigationallegationid ='158d402e-8fcf-4ee6-9043-ead28cb54c9d' and activeflag =1;