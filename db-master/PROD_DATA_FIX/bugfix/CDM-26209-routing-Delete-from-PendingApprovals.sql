/*
-- CDM-26209 - 

-- Issue Description: 
 The case is closed and will not leave my approval box.
  
-- Customer Email ID:lynette.venson@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
*/

update routing set activeflag = 0, updatedby = 'CDM-26209', updatedon = now()
where routingid in ('697aedcf-a76a-45e5-8009-a1513cf2a6db', 'b0a78f7a-d26f-48b0-b8e5-d0d1c1fd707f');