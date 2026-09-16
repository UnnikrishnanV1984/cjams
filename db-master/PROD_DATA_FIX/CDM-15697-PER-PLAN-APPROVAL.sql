   Reason why no related code fix: 
/*
   Issue Description: CDM-15697
      Category/ Module  :  perm plna approvals
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-15697',
		updatedon = now()
	where routingid = '7f7c4101-862d-4ddc-8eac-10789a15eced';