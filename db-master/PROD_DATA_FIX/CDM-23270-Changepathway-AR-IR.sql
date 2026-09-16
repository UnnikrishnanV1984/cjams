/*
   Issue Description: CDM-23270
   Category/ Module  :  data fix to changepathway from AR to IR
   Pull request# for code fix: 5807
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequest set actiontype = 'IR', intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = '23270' where intakeserviceid = '3b075109-2f7d-4b07-b670-2f4e55df11b2';

update intakeservicerequestsdm set isir = true, updatedon = now(),updatedby = 'CDM-23270' where intakeserviceid = '3b075109-2f7d-4b07-b670-2f4e55df11b2';
