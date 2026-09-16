/*
   Issue Description: CDM-16069
   Category/ Module  : child removal
   Root cause: user wants to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   user is asking to remova the child removal duplicate  */


   UPDATE intakeservreqchildremoval 
	SET activeflag = 0,
		updatedby = 'CDM-16069',
		updatedon = now() 
	WHERE intakeservreqchildremovalid = '7e972bdb-e02d-4448-b502-274e8bc50cb6';