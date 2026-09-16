/*
   Issue Description: CDM-18576
      Category/ Module  : case stuck
   Root cause: USER ASKED TO update 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
	SET updatedby = 'CDM-18576', 
		updatedon = now(), 
		activeflag = 0
	WHERE intakenumber = 'I211010196450';

	update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-18576', 
		updatedon = now() 
	where intakenumber = 'I211010196450';

	update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-18576', 
		updatedon = now()
	where intakenumber = 'I211010196450';

	update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-18576',
		updatedon = now()
	where intakenumber = 'I211010196450';

	update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-18576',
		updatedon = now()
	where objectid = 'I211010196450';