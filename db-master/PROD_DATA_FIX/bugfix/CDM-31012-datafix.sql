/*
   Issue Description: CDM-31012
   Category/ Module  :  
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = '0', updatedon = now(), updatedby = 'CDM-31012'
where routingid = 'd80e4d11-97f5-4312-8283-7e932918287a';

update routing set activeflag = '0', updatedon = now(), updatedby = 'CDM-31012'
where routingid = 'a57def6b-4e57-47a0-ba4c-97e9141314c2';

