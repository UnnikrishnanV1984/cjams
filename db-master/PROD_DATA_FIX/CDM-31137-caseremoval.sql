/*
   Issue Description: CDM-31044
   Category/ Module  : Prod data fix to Remove to be assigned cases
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag =0, updatedby ='CDM-31137', updatedon= now() where routingid in('7176323e-c87a-4282-adc0-9e0301bcbb61','259f558f-b2d8-4ad7-b36f-18c4fd4ad3b7');
