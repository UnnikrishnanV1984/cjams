/*
  Issue Description:  CDM-31418
   Category/ Module  : INtake
   Root cause: Case number not displayed in intake
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

update intakeservicerequest set updatedon =now() where intakeserviceid = '13cc9e28-3605-4dde-8354-27565df15d1f' and activeflag =1;