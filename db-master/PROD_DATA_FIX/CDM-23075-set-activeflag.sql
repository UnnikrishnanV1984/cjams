/*
-- CDM-23075- 

-- Issue Description: 
 Unable to remove the items from case approval dashboard
  
-- Customer Email ID: sheritta.barr-stanley1@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-23075', updatedon =  now() where routingid in ('8d4e3f18-91ad-4e39-a8ac-9ad79f11aca8',
'e8ff835b-815d-498a-9363-765b433ad3f0', '2eabd8f9-f70d-4b16-ab7f-fa85b7126db8');