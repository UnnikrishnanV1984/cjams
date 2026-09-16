/*
   Issue Description: CDM-16260
   Category/ Module  :  Updating routing status to APPROVAl status
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--
update routing set routingstatustypeid = 16, updatedby = 'CDM-16260', updatedon = now() where routingid = 'fd5d68ea-08d8-48e9-a7c8-9a1f6ac3f99d';