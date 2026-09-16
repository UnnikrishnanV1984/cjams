/*
   Issue Description: CDM-18081
      Category/ Module  : removing approved items from inbox
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	 set activeflag = 0,
		updatedby = 'CDM-18018',
		updatedon = now()
	where routingid = '40bc3073-ac72-4653-8f82-92b117c303e7';