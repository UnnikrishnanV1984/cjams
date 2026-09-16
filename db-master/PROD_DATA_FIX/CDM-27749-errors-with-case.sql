/*
  Issue Description: CDM-27749
   Category/ Module  : Case was not displaying in casesearch
   Root cause: user wanted to view the case in casesearch
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update intakeservicerequest set 
actiontype = 'AR',
updatedon = now(),
updatedby ='CDM-27749'
where servicerequestnumber = '221020291373';

update intakeservicerequest 
set intakeservicerequestclassid = 'b74ded78-12dc-4e6d-94db-7662d6eaf093' , 
updatedby = 'CDM-27749',
updatedon = now() 
where servicerequestnumber ='221020291373' ;