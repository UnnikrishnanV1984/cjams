/*
-- CDM-24687 - 

-- Issue Description: 
 The case is closed and will not leave my approval box.
   
-- Customer Email ID:lynette.venson@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
*/
update routing set activeflag = 0, updatedby = 'CDM-24687', updatedon = now()
where routingid in ('3ec3f484-86d5-4be7-8e2d-f09f355576ba', '686ec769-d9c3-4a12-a143-ef9bb3b640cd', '5c58b2ef-7fe3-4402-ad46-4378852052bf');