/*
-- CDM-20740 - 

-- Issue Description: 
 The worker end dated the permanency plan without completing an end date. 
 CJAM report shows wrong because end date needs entered
  
-- Case ID: 2020019201780

-- Root cause: Data fix updated the permanency plan end reason
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update permanencyplan set reason='Permanency plan changed to adoption', updatedby='CDM-20740',updatedon =now() where permanencyplanid ='d7175eff-26da-49e7-8eec-1a5616f922f4'; 
