/*
   Issue Description: CDM-31122
   Category/ Module  : Intake is not available in global search and Head of HouseHold was missing
   Root cause: user wnats to change the agreement startdate
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set intakenumber = 'I231010591880',updatedon = now(), updatedby = 'CDM-31122' where intakeservicerequestactorid = '5e3b7411-689d-420b-87cf-e135d1266ef7';

update intakedastatus set intakeuser = '47dc653d-9089-4b47-b40e-0168ef6c2321', updatedon = now(), updatedby = 'CDM-31122' where  intakenumber = 'I231010591880' and intakeuser <> '47dc653d-9089-4b47-b40e-0168ef6c2321';