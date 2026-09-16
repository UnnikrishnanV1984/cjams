/*
   Issue Description: CDM-31122
   Category/ Module  : Intake is not available in global search and Head of HouseHold was missing
   Root cause: user wnats to change the agreement startdate
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set isprimary = 'true', updatedon = now(), updatedby = 'CDM-31122'
where intakeservicerequestactorid = '9bb1beba-93fb-481d-b522-aa957a48b97a' and activeflag  = 1;

update intakedastatus set intakeuser = '47dc653d-9089-4b47-b40e-0168ef6c2321', updatedon = now(), updatedby = 'CDM-31122' where  intakenumber = 'I231010591880';