/*
   Issue Description: CDM-17927
      Category/ Module  : child removal
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	set activeflag = 0,
		updatedby = 'CDM-17927',
		updatedon = now()
	where routingid in ('0ebc898e-09cc-4c92-a9cb-16d048045bab', 'fb9ca1f5-c56e-4222-ac72-418b456c3536');