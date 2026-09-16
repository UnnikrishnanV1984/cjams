
/*
   Issue Description: CDM-19691
   Category/ Module  : case assign missing in dashboard
   Root cause: user wants to see case in assign dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest ISR set isrouted = true,updatedby ='CDM-19691',updatedon =now() WHERE  ISR.intakeserviceid ='c6576ead-557e-4607-a339-da64c2137482';
