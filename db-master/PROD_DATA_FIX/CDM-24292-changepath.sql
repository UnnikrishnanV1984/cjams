/*
   Issue Description: CDM-24292
   Category/ Module  : SDM
   Root cause: user requeseted to update ir status
   Pull request# for code fix: 
   Reason why no related code fix: user is already submitted
*/


update cjams.intakeservicerequestsdm set isir ='false', isar='true', updatedby ='CDM-24292', updatedon =now()where intakeservicerequestsdmid ='0e1ff698-9c83-43ae-ac40-9088244f9ceb';
