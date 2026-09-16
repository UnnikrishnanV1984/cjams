/*
   Issue Description: CDM-17896
   Category/ Module  : case-removal 
   Root cause: case was opened as an investigation in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequest set activeflag =0 , updatedby = 'CDM-17896' where intakeserviceid ='45b306c8-cdc2-45ef-965c-cebd9717029c'

update routing set activeflag =0 , updatedby = 'CDM-17896' where routingid ='3e4c601f-f04e-49d7-9876-7c37489c5c14'