/*
   Issue Description: CDM-16951
      Category/ Module  :  duplicate referral
   Root cause: duplicate referral
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
	SET updatedby = 'CDM-16951', 
		updatedon = now(), 
		activeflag = 0
	WHERE intakenumber = 'I211010190173';

	update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-16951', 
		updatedon = now() 
	where intakenumber = 'I211010190173';

	update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-16951', 
		updatedon = now()
	where intakenumber = 'I211010190173';

	update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-16951',
		updatedon = now()
	where intakenumber = 'I211010190173';

	update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-16951',
		updatedon = now()
	where objectid = 'I211010190173';