/*
   Issue Description: CDM-18087
         Category/ Module  : removing approved items from inbox
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	set activeflag = 0,
		updatedby = 'CDM-18087',
		updatedon = now()
	where routingid = 'd74fcda5-6801-400c-b092-7651f2a53938';