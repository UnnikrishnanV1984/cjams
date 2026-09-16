/*
   Issue Description: CDM-31056
   Category/ Module  : Safe c Updated By (case)
   Root cause:Safe c has incorrect worker name in Updated 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update routing r set fromsecurityusersid = '5321bcf2-3dd0-49a5-94a4-580c0750348c',updatedby = 'CDM-31056' , updatedon = now()
 WHERE 
 r.objectid = 'd1d5d190-22a5-4bd0-92df-c827be058e55'::character varying
 and routingstatustypeid=15 and servicerequestnumber='231020507547';
