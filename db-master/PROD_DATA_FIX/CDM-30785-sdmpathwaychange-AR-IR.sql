/*
   Issue Description: CDM-30785
   Category/ Module  :  data fix to changepathway from AR to IR
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequest set actiontype = 'IR', intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = 'CDM-30785' where intakeserviceid = '9d1ee202-2716-473b-b2ca-3f2ac64bae3e';

update intakeservicerequestsdm set isir = true, updatedon = now(),updatedby = 'CDM-30785' where intakeserviceid = '9d1ee202-2716-473b-b2ca-3f2ac64bae3e';
