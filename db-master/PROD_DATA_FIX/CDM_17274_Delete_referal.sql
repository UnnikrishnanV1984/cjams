/*
   Issue Description: CDM-17274
   Category/ Module  : delete referal
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked remove intake refereal which was wrongly created
*/


UPDATE intakesnapshot 
	SET updatedby = 'CDM-17274', 
		updatedon = now(), 
		activeflag = 0
	WHERE intakenumber = 'I211010179241';

	update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-17274', 
		updatedon = now() 
	where intakenumber = 'I211010179241';

	update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-17274', 
		updatedon = now()
	where intakenumber = 'I211010179241';

	update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-17274',
		updatedon = now()
	where intakenumber = 'I211010179241';

	update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-17274',
		updatedon = now()
	where objectid = 'I211010179241';