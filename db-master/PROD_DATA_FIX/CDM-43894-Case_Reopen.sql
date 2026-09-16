/*
   Issue Description: CDM-43894
   Category/ Module  : Case Reopen
   Root cause: User requested to reopen case.
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

update intakeservicerequest 
set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-43894'
where intakeserviceid = '84b3e798-8982-47a7-acd0-af4d1fd49a5d' and activeflag = 1;

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, updatedby = 'CDM-43894', updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = 'a0afcbba-61a9-493e-a8c9-388a7bdd223b' and activeflag = 1;

update caseassignment 
set enddate = null, updatedby = 'CDM-43894', updatedon = now() 
where caseassignmentid ='c4a4dd4e-f4ba-48e8-a13a-59e17607d40a' and activeflag = 1;

update personprogramarea set enddate = null, updatedby = 'CDM-43894', updatedon = now() 
where entityid = '241022928239' and activeflag =1;