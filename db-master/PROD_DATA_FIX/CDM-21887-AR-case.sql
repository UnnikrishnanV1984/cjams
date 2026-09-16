
 /*
  Issue Description: CDM-21887 Missing AR CPS Case
   Category/ Module  :  AR case
   Root cause: QA team is trying to replicate this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update intakeservicerequest set activeflag=1, updatedby='CDM-21887', updatedon=now() where intakenumber='I221010241207' 
and intakeserviceid='1bf6f4ef-c168-407a-b85a-1d8a4cb1db52';