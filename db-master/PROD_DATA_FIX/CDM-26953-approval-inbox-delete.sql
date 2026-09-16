/*
-- CDM-26953 - 

-- Issue Description: 
Dashboard:SEE case for Melissa Anderson - her 
permanency plan has been updated and approved yet it remains on my approval inbox. please help to deletethanks
-- Customer Email ID:

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-26953' 
where routingid='1a05dc18-92a1-45b9-a916-8b1bc3de51ca';