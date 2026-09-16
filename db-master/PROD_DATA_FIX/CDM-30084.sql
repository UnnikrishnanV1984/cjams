/*
   Issue Description: CDM-30084
   Category/ Module  : Intake
   Root cause:user want to update service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update cjams.intakeservicerequest set servicecaseid=null,updatedby='CDM-30084',updatedon=now() where  intakeserviceid='27e7658e-0b42-46b7-9e4b-bd899fe2caf6';