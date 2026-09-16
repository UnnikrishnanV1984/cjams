/*
  Issue Description: CDM-21551
   Category/ Module  :  permanency plan end date and update and deleted
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan set enddate = '2020-02-27 00:00:00', updatedby = 'CDM-21551', updatedon = now()  where permanencyplanid = '67765aba-9a6a-4003-93ed-9b158bde66fe';

update permanencyplan set activeflag = 0, updatedby = 'CDM-21551', updatedon = now() where permanencyplanid = '172552f0-e49c-41a9-9df9-96f0f371ef73';
