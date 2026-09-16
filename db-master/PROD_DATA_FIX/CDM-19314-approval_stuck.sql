/*
   Issue Description: CDM-19314
   Category/ Module  : Approval stuck on my approval inbox 
   Root cause: Case shows pending in approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--SELECT * FROM getpendingreviewda('ef3032b3-2f5a-4b48-8b27-c33cf654abf6',1,10, ''); 
 
update cjams.routing 
set activeflag  = 0, updatedby = 'CDM-19314', updatedon = now() 
where eventcode = 'CPLAN2' and routingid = 'f71adfde-ce9a-440e-8727-cb4684ceb0e3';