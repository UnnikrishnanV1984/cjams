
/*
   Issue Description: CDM-31031
   Category/ Module  : Dashboard
   Root cause: User wants to screenout Intake and remove CPS AR case
   Pull request# for code fix: 8894
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-31031',
  updatedon = now() 
where objectid = '054fd9f2-9343-4254-ae46-9c76106420cb' and activeflag = 1;


UPDATE servicecase 
SET activeflag = 0,
updatedby = 'CDM-31031',
updatedon = now() 
WHERE servicecaseid = '054fd9f2-9343-4254-ae46-9c76106420cb';

UPDATE servicecasedisposition 
SET activeflag = 0,
updatedby = 'CDM-31031',
updatedon = now() 
WHERE servicecaseid = '054fd9f2-9343-4254-ae46-9c76106420cb';