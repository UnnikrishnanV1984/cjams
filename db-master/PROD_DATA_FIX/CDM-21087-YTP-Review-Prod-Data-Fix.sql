/*
   Issue Description: CDM-21087
   Category/ Module  : case approval
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set objectid = '4851848c-8339-4f8b-8898-0b52dfedf959',updatedby = 'CDM-21087', updatedon = now(), activeflag=0
where routingid = '8033e2c5-7f7b-4b54-b565-26881693616e';
