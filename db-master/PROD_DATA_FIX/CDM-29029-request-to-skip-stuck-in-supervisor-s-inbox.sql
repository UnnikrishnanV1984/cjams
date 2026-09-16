/*
   Issue Description: CDM-29029
      Category/ Module  : Approval inbox
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	 set activeflag = 0,
		updatedby = 'CDM-29029',
		updatedon = now()
	where routingid = 'd5f4c89d-6004-4599-8682-225de44efd3a';