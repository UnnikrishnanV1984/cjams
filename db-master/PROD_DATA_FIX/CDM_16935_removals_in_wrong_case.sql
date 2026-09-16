/*
   Issue Description: CDM-16935
   Category/ Module  : Approval removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/


UPDATE Intakeservreqchildremoval
	SET activeflag = 0, 
		updatedby = 'CDM-16935',
		updatedon = now() 
	WHERE intakeservreqchildremovalid in ('80f59634-c46a-4f9f-8bc6-3b7445e562f1', '36078675-51b1-4ef8-a821-08cc28347372');