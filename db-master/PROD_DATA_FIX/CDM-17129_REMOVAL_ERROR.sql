/*
   Issue Description: CDM-17129
      Category/ Module  : Removal error
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to reopen  AR case

  */


  UPDATE Intakeservreqchildremoval
	SET exitdate = null, updatedby = 'CDM-17129', updatedon = now() 
	WHERE intakeservreqchildremovalid = '560f42e7-7fb8-4b52-bdcc-0cf6e2e146c4';
		
	update personprogramarea set enddate = null, updatedby = 'CDM-17129', updatedon = now() 
	where personprogramid = '4a1ea348-9bf8-4d53-91fe-4df538cc2789';