/*
   Issue Description: CDM-29095
      Category/ Module  : Approval inbox
   Root cause: User asked to remove the related case from the approval dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	 set activeflag = 0,
		updatedby = 'CDM-29095',
		updatedon = now()
	where routingid = 'a18d535a-b179-436e-b5f5-3667007bdff3';