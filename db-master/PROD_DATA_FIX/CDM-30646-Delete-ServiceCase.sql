/*
   Issue Description: CDM-30646
   Category/ Module  : Delete Servicecase
   Root cause: user requested to remove the servicecases created in error
   Pull request# for code fix: 8757
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
update servicecase set activeflag =0, updatedby = 'CDM-30646', updatedon = now() 
where servicecaseid in ('8e85414a-49d2-4e53-a3d2-1b7bf97c2c9c', 'b4d38d27-b83d-42ee-a879-936fafdf79c1');

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-30646', updatedon = now() 
where servicecaseid in ('8e85414a-49d2-4e53-a3d2-1b7bf97c2c9c', 'b4d38d27-b83d-42ee-a879-936fafdf79c1');

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-30646' 
where routingid in ('c22357e3-8071-4e4b-8c51-5cf983fe842f', '824ee0b3-0102-4799-9748-efdd00dbb28c');