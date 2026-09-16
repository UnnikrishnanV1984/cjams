/*
   Issue Description: CDM-17399
   Category/ Module  : Perm plan
   Root cause: user asked to rupdated
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	set activeflag = 0,
		updatedby = 'CDM-17399',
		updatedon = now()
	where routingid = '401930fa-690a-41ca-bedf-074efc25f5b3';
