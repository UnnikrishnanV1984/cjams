/*
   Issue Description: CDM-40102
   Category/ Module  : Case Timeline
   Root cause: user request to remove the intake 
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update intakedastatus
	set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-40102'
	where intakenumber = 'I241012742995'
		and activeflag = 1;
	

	
update intakedastaging
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-40102'
	where intakenumber = 'I241012742995'
		and activeflag = 1;
		

	
	update intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-40102'
	where intakenumber = 'I241012742995'
		and activeflag = 1;

	
	update actor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-40102'
	where intakenumber = 'I241012742995'
		and activeflag = 1;
	 
	
	
	update actorrelationship
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-40102'
	where intakenumber = 'I241012742995'
		and activeflag = 1;

	
	update personrole
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-40102'
	where intakenumber = 'I241012742995'
		and activeflag = 1;
		
		
