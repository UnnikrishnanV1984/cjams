/*
  Issue Description:CDM-42629
Category/ Module:Application
Root cause: User requested to delete the intake.
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

update intakedastatus 
set activeflag = 0,updatedby = 'CDM-42629',updatedon = now()
where intakenumber = 'I241013172403' and activeflag = 1;

update intakedastaging 
set activeflag = 0,updatedby = 'CDM-42629',updatedon = now()
where intakenumber = 'I241013172403' and activeflag = 1;


