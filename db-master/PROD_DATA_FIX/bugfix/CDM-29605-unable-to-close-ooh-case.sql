/*
   Issue Description: CDM-29605-unable-to-close-ooh-case
   Category/ Module  : CDM
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/


update intakeservicerequestactor set 
updatedby = 'CDM-29605', updatedon = now(),
isprimary ='true' where intakeservicerequestactorid = '6929ff39-e8e4-44f4-897c-1522d52fb2e3'
and personid = '5c7b30ea-786e-4cec-a670-d928e96392af';