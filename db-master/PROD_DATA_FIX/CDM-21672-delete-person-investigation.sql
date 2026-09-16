/*
-- CDM-21672 - 

-- Issue Description: 
 Unable to delete the other person under the investigation tab.
  
-- Customer Email ID: rachelle.thomas1@maryland.gov

-- Root cause: Data fix to delete the person under the investigation tab
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update investigationallegation set activeflag = 0, updatedon = now(), updatedby = 'CDM-21672'
where investigationallegationid = '335af150-598f-43da-b181-2d8097ffbea5';