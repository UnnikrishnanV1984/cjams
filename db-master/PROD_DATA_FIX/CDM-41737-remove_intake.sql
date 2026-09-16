/*
   Issue Description: CDM-41737
   Category/ Module  : delete referal
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked remove intake refereal which was wrongly created
*/


UPDATE intakesnapshot 
	SET updatedby = 'CDM-41737', 
		updatedon = now(), 
		activeflag = 0
	WHERE intakenumber = 'I241013142839';

update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-41737', 
		updatedon = now() 
	where intakenumber = 'I241013142839';

update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-41737', 
		updatedon = now()
	where intakenumber = 'I241013142839';

update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-41737',
		updatedon = now()
	where intakenumber = 'I241013142839';

update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-41737',
		updatedon = now()
	where objectid = 'I241013142839';
	