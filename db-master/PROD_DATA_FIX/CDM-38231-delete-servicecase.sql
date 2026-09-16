/*
   Issue Description: CDM-38231
   Category/ Module  : Delete Servicecase
   Root cause: user requested to remove the servicecases created in error
   Pull request# for code fix: 8757
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update servicecase set activeflag =0, updatedby = 'CDM-38231', updatedon = now() 
where servicecaseid in ('a062e4e8-739d-4abd-8839-6de58b1953d7');

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-38231', updatedon = now() 
where servicecaseid in ('a062e4e8-739d-4abd-8839-6de58b1953d7');

update caseassignment set activeflag = 0, updatedby = 'CDM-38231', updatedon = now() 
where objectid = 'a062e4e8-739d-4abd-8839-6de58b1953d7';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-38231' 
where routingid in ('40c10031-5a57-45bd-8447-e1d08a0c24fc');