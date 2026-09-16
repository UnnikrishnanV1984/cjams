
/*
-- CDM-24946 - 

-- Issue Description: 
 The case is closed and will not leave my approval box
 
-- Customer Email ID:jason.sammons@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
*/

update routing set activeflag =0, updatedby = 'CDM-24946', updatedon = now() where objectid= '9762b567-2f01-40e7-9a64-bd2caa0c689b' and entityid= '339e784a-ae4b-47bc-b7fb-83a03d08f02b'