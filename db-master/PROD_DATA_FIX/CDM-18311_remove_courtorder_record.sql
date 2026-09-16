/*
   Issue Description: CDM-18311
   Category/ Module  : Court Order
   Root cause: User requested to remove the records from court order
   Pull request# for code fix: 4404
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequestcourthearing set activeflag = 0, updatedby = 'CDM-18311', updatedon = now() where intakeservicerequestcourthearingid = 'ff1721f6-2c3c-43e9-9c9f-43a59aff1323' and intakeservicerequestcourthearingid = 'ff1721f6-2c3c-43e9-9c9f-43a59aff1323'