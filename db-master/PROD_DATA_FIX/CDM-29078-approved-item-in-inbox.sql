/*
   Issue Description: CDM-29078
      Category/ Module  : Approval inbox
   Root cause: User asked to remove the related case from the approval dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
	 set activeflag = 0,
		updatedby = 'CDM-29078',
		updatedon = now()
	where routingid = '0d9a4875-027c-48da-8f84-16ab79bdbaf5';