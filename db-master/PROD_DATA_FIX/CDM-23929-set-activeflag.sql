/*
-- CDM-23929-- 

-- Issue Description: 
 Unable to remove approval items from dashboard

-- Customer Email ID: cheryl.paige@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-23929' , updatedon = now()  where routingid in ('7501fbba-0e89-475f-bd83-556b86a48c0e',
'3974cecc-f831-435a-b232-72a806996bc6',
'2192939e-fea3-4d07-b7a2-31caa3d201c5',
'9e243a73-3d04-4504-a3cf-1aad007cd6e0',
'cd15e4ae-06d0-47d5-ba68-4608cfb205dc',
'fb796bd4-c4f1-4e21-b18f-7570fa6240da') and activeflag = 1;