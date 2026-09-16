/*
   Issue Description: CDM-30136
   Category/ Module  : duplicate child in case assignment list
   Root cause: Duplicate records in intakeservicerequestactor
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservicerequestactor isa set activeflag = 0 , updatedby = 'CDM-30136'
where intakeserviceid  = '494feed3-4156-4f71-90fd-d5d9c34f8c9c'
AND activeflag  = 1;