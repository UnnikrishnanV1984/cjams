/*
   Issue Description: CDM-28751
   Category/ Module  :revert intake supervisor decision 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   new case number : 231030066802
*/

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = 'c57f125b-0229-424a-9bfe-3031f3c446f6',
updatedby = 'CDM-28751',updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = 'af1bce7f-e4e6-4e98-b150-c1cb01bd1338';