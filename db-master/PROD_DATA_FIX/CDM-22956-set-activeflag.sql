/*
-- CDM-22956- 

-- Issue Description: 
 Unable to delete duplicate YTP Review
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to delete duplicate YTP Review
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22956', updatedon = now()  where routingid = '8b4ad202-7e87-4195-9dfb-172eac90482b';
