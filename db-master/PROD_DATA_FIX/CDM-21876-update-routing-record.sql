/*
-- CDM-21876- 

-- Issue Description: 
 Submit for approval is inactive
  
-- Customer Email ID: lindaj.luallen@maryland.gov

-- Root cause: Data fix to update the routing record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 1, updatedby = 'CDM-21876', updatedon = now() where routingid = '606cb7bd-5981-4c13-a9a5-41940f7db8b3' and activeflag = 0;