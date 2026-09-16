/*
		CDM-16436			
	    USER ASKED TO REMOVE 2 INTAKE REQUEST.
		
	*/

UPDATE intakesnapshot 
	SET updatedby = 'CDM-16436', 
		updatedon = now(), 
		activeflag = 0
	WHERE intakenumber = 'I211010186038';

	update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-16436', 
		updatedon = now() 
	where intakenumber = 'I211010186038';

	update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-16436', 
		updatedon = now()
	where intakenumber = 'I211010186038';

	update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-16436',
		updatedon = now()
	where intakenumber = 'I211010186038';

	update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-16436',
		updatedon = now()
	where objectid = 'I211010186038';


	update intakeservicerequestactor 
	set activeflag = 0, 
		updatedby = 'CDM-16436', 
		updatedon = now() 
	where intakenumber = 'I211010186038';