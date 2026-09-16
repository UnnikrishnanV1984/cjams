/*
-- CDM-21450- 

-- Issue Description: 
 Unable to reject the purchase authorization
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to reject the purchase authorization
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set remarks='Funding Approval Denied', routingstatustypeid = 62, updatedon = now(), updatedby = 'CDM-21450' where routingid = '38e06e16-ee89-40e7-a27d-74301be487bb' and eventcode = 'PCAUTHR';