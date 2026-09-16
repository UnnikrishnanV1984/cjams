/*
   Issue Description: CDM-39220
   Category/ Module  :  IR-summary
   Root cause: safec checklist is not checked in Investigation summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update assessmentactor set intakeservicerequestactorid ='76dd6c93-085b-45f5-925d-1cccb35c81ec',updatedby ='CDM-39220',updatedon =now() 
where assessmentactorid = 'ef6b6c37-9bc9-4655-adab-8a71fcab7322';
