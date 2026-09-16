/*
  Issue Description:  CDM-40130
   Category/ Module  :  Assignments
   Root cause: Completed CPS IR Case# 241022156086 is not listed in the assign case dashboard. This has occured as the case is not routed correctly.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update intakeservicerequest 
set isrouted = true,
updatedby ='CDM-40130',
updatedon = now() 
where intakeserviceid ='f01731d7-da27-40c1-a44f-0861976cec87' and activeflag =1;