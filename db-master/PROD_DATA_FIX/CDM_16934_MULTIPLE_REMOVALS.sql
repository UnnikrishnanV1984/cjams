/*
   Issue Description: CDM-16934
   Category/ Module  : child  removal
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/


UPDATE Intakeservreqchildremoval
	SET activeflag = 0, 
		updatedby = 'CDM-16934',
		updatedon = now() 
	WHERE intakeservreqchildremovalid in ('2a5814fc-1b44-43ee-8652-fdf72f22bbdf', 'c8342a4e-dfb3-4755-a011-feec53853cde');