/*
   Issue Description: CDM-34186
   Category/ Module  : Assign Dashboard
   Root cause:  Completed case missing in dashboard 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest set isrouted = true, updatedby ='CDM-34186',updatedon =now() where intakeserviceid ='f30d6798-c2be-457a-a4e9-1269d1c64ee0';