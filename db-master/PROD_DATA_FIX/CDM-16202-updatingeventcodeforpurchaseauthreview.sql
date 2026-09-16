/*
   Issue Description: CDM-16202
   Category/ Module  :  updated pending Approval for LDSS supervisor
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- PCAUTH
update routing set eventcode = 'PCAUTHR', updatedon = now(), updatedby = 'CDM-16202' where routingid = '2caf9ae6-183b-4f93-8126-e7c999eb1ebe';
	