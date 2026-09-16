/*
   Issue Description: CDM-21008
   Category/ Module  : CPS IRcase to AR
   Root cause: user wants change the case 
   Pull request# for code fix: 4994
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update intakeservicerequest set actiontype = 'IR', intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = 'CDM-21008' where intakeserviceid = 'eab8a416-4eff-4061-85c9-4064cb77c481';
update intakeservicerequestsdm set isir = true, updatedon = now(),updatedby = 'CDM-21008' where intakeserviceid = 'eab8a416-4eff-4061-85c9-4064cb77c481';