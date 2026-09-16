/*
-- Issue Description: 
	CDM-30190-service case removal
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/




update servicecase set activeflag =0, updatedby = 'CDM-30190', updatedon = now() 
where servicecaseid = '7da8129b-74b6-43a0-b77a-06d638a05898';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-30190', updatedon = now() 
where servicecaseid = '7da8129b-74b6-43a0-b77a-06d638a05898';

update servicecaserequest set activeflag = 0, updatedby = 'CDM-30190', updatedon = now() 
where servicecaseid = '7da8129b-74b6-43a0-b77a-06d638a05898';

update caseassignment set activeflag = 0, updatedby = 'CDM-30190', updatedon = now()
where objectid = '7da8129b-74b6-43a0-b77a-06d638a05898'
and activeflag = 1;