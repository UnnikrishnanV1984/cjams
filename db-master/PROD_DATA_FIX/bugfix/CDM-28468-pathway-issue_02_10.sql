/*
   Issue Description: CDM-28468
   Category/ Module  :Pathway issue
   Pull request# for code fix: Update to IR
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequestsdm set isir = true,
updatedby = 'CDM-28468', updatedon = now()
where intakeservicerequestsdmid = '59851f3e-c054-4b8c-ad50-6e5b813e7d49';
 
update intakeservicerequest set intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', 
updatedby = 'CDM-28468', updatedon = now()
where intakeserviceid = 'fc783c57-046b-481a-b83a-5b7992c69906';