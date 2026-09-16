/*
-- Issue Description: 
   User request to Remove duplicated Investigation findings
-- Category/ Module: Inverstigation Finding   
-- Root cause: 
-- Pull request :7485
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update investigationallegation
set activeflag = 0, updatedby = 'CDM-27126', 
updatedon= now() 
where investigationallegationid = 'feb19d22-b580-4feb-abb8-66889e7e783c';