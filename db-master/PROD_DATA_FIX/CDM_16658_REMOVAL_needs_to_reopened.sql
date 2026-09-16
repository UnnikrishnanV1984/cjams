UPDATE intakeservreqchildremoval 
	SET exitdate=null,  
		updatedby='CDM-16658',
		updatedon=now() 
	WHERE intakeservreqchildremovalid = 'dafad745-c906-49ea-8c55-3d15fcd48333';

	-- OPENING OOH CASE

	update personprogramarea set enddate = null, updatedby = 'CDM-16658', updatedon = now() where personprogramid = '123e4ce5-e4e6-4933-b85d-42b7624eda51';