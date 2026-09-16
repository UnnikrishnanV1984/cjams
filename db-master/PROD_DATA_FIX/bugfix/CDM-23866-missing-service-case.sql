/*
   Issue Description: CDM-23866
   Category/ Module  : 221030017232:This Services case is missing the Head of Household.
   Root cause: 
   Pull request# for code fix: 5705
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update intakeservicerequestactor set servicecaseid = 'e0228f33-ec5b-4226-9200-3a1fcceffdb9', updatedon = now(), updatedby = 'CDM-23866' where intakeservicerequestactorid  = 'be522746-39bf-438a-8044-f56bb2c627c5';
