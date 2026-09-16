/*
   Issue Description: CDM-23409
   Category/ Module  : Prod data fix to change from AR to IR
   Pull request# for code fix: 5789
   Reason why no related code fix: User unable to select dreopdown to change from AR to IR
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequestsdm set isar = true , updatedby ='CDM-23409', updatedon = now() where intakeservicerequestsdmid ='7b8a4ea7-8f89-4a08-b739-ae63b33fecc8';