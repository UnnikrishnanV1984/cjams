/*
  Issue Description: CDM-42810- Intake_Closure
   Category/ Module  :  Intake
   Root cause: User requested for intake closure
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, 
   Backup before update/ delete:
*/

update intakedastatus 
	set activeflag = 0, updatedon = now(), updatedby = 'CDM-42810' 
where intakenumber = 'I241013167867' and activeflag =1;

update intakedastaging 
	set activeflag=0, updatedon = now(), updatedby = 'CDM-42810' 
where intakenumber ='I241013167867' and activeflag=1;