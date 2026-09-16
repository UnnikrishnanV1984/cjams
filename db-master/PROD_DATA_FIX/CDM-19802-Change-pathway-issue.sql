/*
   Issue Description: CDM-19802
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest set actiontype = 'IR', intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = 'CDM-19802' where intakeserviceid = 'c2df8c81-5de3-48fd-abd8-24c3090cd35d';
update intakeservicerequestsdm set isir = true, isar = false, updatedon = now(),updatedby = 'CDM-19802' where intakeserviceid = 'c2df8c81-5de3-48fd-abd8-24c3090cd35d';

	