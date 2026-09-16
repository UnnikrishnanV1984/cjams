/*
   Issue Description: CDM-16993
   Category/ Module  : duplicate removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

UPDATE Intakeservreqchildremoval
	SET activeflag = 0, 
		updatedby = 'CDM-16993',
		updatedon = now() 
	WHERE intakeservreqchildremovalid = '4f4a386c-53e2-4342-9789-84cd7fd25cef';

	UPDATE routing 
	SET activeflag = 0, 
		updatedby = 'CDM-16993',
		updatedon = now() 
	WHERE objectid = '4f4a386c-53e2-4342-9789-84cd7fd25cef';