/*
   Issue Description: CDM-39221
   Category/ Module  :  IR-summary
   Root cause: safec checklist is not checked in Investigation summary
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update assessmentactor set intakeservicerequestactorid ='06d6762c-a758-4dca-a27e-76333aa70214',updatedby ='CDM-39221',updatedon =now() 
where assessmentactorid = 'bc1d73da-42c5-4c88-a622-fa009833a30b';
