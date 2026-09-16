/*
-- CDM-22180 - 

-- Issue Description: 
 Unable to closed cases on dashboard
  
-- Customer Email ID: shelley.brown@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0,
updatedby = 'CDM-22180', updatedon = now() 
where routingid in ('cb0755f0-175f-4373-b0ea-46fdb04a025a','e509c283-e78d-4e89-a66a-1fbae11edf5e') and activeflag = 1;