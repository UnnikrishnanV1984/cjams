/*
   Issue Description: CDM-27692
   Category/ Module  : Prod data fix to the pathway change
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update intakeservicerequest set actiontype = 'IR', intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = 'CDM-27692' 
where intakeserviceid = '872054d4-f745-4232-b8e5-1c970ad1e9cb';

update intakeservicerequestsdm set isir = true, updatedon = now(),updatedby = 'CDM-27692' where intakeserviceid = '872054d4-f745-4232-b8e5-1c970ad1e9cb';
