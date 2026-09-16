/*
   Issue Description: CDM-18136
   Category/ Module  : Removing person from servicecase
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-18136', updatedon = now() where intakeservicerequestactorid = 'acd788b4-4e75-41a6-88a1-6925398bdf87' and activeflag = 1;