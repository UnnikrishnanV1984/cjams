/*
   Issue Description: CDM-19315
   Category/ Module  : Approval stuck on my approval inbox 
   Root cause: Case shows pending in approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--SELECT * FROM getpendingreviewda('e12d7ff7-c158-45bd-8d59-b84e4485616d',1,10, '');  

update cjams.routing 
set activeflag  = 0, updatedby = 'CDM-19315', updatedon = now() 
where eventcode = 'SCDR' and routingid in ('b66527e6-8ee0-4848-af4b-926a8d0c42ea', '79494639-e0f5-4e0e-84b6-4682ee2f6043');