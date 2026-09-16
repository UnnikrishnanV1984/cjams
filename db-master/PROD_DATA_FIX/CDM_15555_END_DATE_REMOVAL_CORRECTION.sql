/*
   Issue Description: CDM-15555
   Category/ Module  :  removal dates
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

UPDATE Intakeservreqchildremoval
	SET exitdate = null, updatedby = 'CDM-15555', updatedon = now() 
	WHERE intakeservreqchildremovalid in  ('3bb819b9-0cee-4724-964b-c6bced79c055', '4b22aaed-3ce4-4136-bec3-e2f5e9282786');

	update personprogramarea 
	set enddate = null, updatedby = 'CDM-15555', updatedon = now() 
	where personprogramid in ('83baa7dd-b863-4928-8d33-12733c49213a', '0fd2ba3f-b4f3-42e1-8e79-c26b89a41f4d');