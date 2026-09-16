/*
   Issue Description: CDM-16436
   Category/ Module  : STUCK case approvals
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/

UPDATE intakesnapshot 
	SET updatedby = 'CDM-16436', 
		updatedon = now(), 
		activeflag = 0
	WHERE intakenumber in ('I211010186038', 'I202100517603');

	update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-16436', 
		updatedon = now() 
	where intakenumber in ('I211010186038', 'I202100517603');

	update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-16436', 
		updatedon = now()
	where intakenumber in ('I211010186038', 'I202100517603');

	update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-16436',
		updatedon = now()
	where intakenumber in ('I211010186038', 'I202100517603');

	update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-16436',
		updatedon = now()
	where objectid in ('I211010186038', 'I202100517603');


	update intakeservicerequestactor 
	set activeflag = 0, 
		updatedby = 'CDM-16436', 
		updatedon = now() 
	where intakenumber in ('I211010186038', 'I202100517603');