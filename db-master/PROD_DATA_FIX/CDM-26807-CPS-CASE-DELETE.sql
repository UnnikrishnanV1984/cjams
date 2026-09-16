/*
-- CDM-26530 - 

-- Issue Description: 
 We need a Data Fix to Override ScreenOut this Intake I221010336289 and delete the CPS AR Case 221020272930.
Also need to make sure the Program Assignment related to the CPS AR case 221020272930 need to be deleted from the person program Assignment.
  
-- Customer Email ID:

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 4934
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-26807', updatedon = now() 
where 
routingid='ee3b4ff1-2641-4dd5-a516-b86451d3632b';