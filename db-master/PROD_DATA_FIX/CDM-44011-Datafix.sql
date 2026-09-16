/*
   Issue Description: CDM-44011
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-44011', 
		updatedon = now()
	where intakenumber = 'I241013181876' and activeflag=1;

update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-44011',
		updatedon = now()
	where intakenumber = 'I241013181876' and activeflag=1;