
/*
   Issue Description: CDM-31235
   Category/ Module  :  Approval inbox 
   Root cause: Approval records  
   Pull request# for code fix: 
   Reason why no related code fix: checked the proc changes everything is good seems to be it's a glitch
*/

update cjams.routing set activeflag= 0, updatedby ='CDM-31235', updatedon = now()
where routingid ='464b62e7-ec2c-4421-9d4f-e2768318ab7e';