/*
  Issue Description:  CDM-42813
   Category/ Module  :  Case Timeline
   Root cause: User request to delete the case 
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update intakedastatus
set	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-42813'
where intakenumber = 'I241013176381' and activeflag = 1;

update intakedastaging
set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-42813'
where intakenumber = 'I241013176381'
		and activeflag = 1;

    --No records found in other tables