
/*
   Issue Description: CDM-21618
   Category/ Module  : Prod data fix for updating Guardian Relation ship
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

 --5011766  2022-03-02 00:00:00
   update adoptioncaseagreement set
   enddate  = '2025-03-02 00:00:00', updatedby = 'CDM-21670', updatedon = now() 
   where adoptionagreementid = 'afeb4e9d-9822-4a52-8a0b-37a9dee727b2';

   
  --5011766  2022-03-02 00:00:00
   update adoptioncaseagreement set
   enddate  = '2025-03-30 00:00:00', updatedby = 'CDM-21670', updatedon = now() 
   where adoptionagreementid = 'deec753d-765b-4ecf-9656-8b27bc4fe461';