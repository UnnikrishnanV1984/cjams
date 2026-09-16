/*
   Issue Description: CDM-21197
   Category/ Module  : case approval
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan set enddate = '2020-04-07 00:00:00',updatedon = now(), updatedby = 'CDM-21197' where permanencyplanid = 'f52ca5d0-d5ca-4bff-88de-1ef1193f1456';
