/*
   Issue Description: CDM-22188
   Category/ Module  : Prod data fix to remove person from service case
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservicerequestactor i 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22188'
where intakeservicerequestactorid = 'df079b80-5382-4a50-9978-abb0eae5a3a1';

update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-22188'
where actorid = 'da8e477d-b401-4281-ad29-5c9ffaddd9fe';