/*
   Issue Description: CDM-28745
   Category/ Module  : revert intake supervisor decision 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   new case number : 231030066769
*/

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = 'b9de0950-9b7c-4f10-ba45-d9561583dbb6',
updatedby = 'CDM-28745',updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '0c84f88a-0d42-4168-b9d2-c6e28e628c05';