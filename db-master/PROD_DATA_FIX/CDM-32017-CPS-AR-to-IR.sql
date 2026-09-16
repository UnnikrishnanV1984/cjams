/*
   Issue Description: CDM-32017
   Category/ Module  :Intake 
   Root cause:CPS-AR case got generated wrongly instead of CPS-IR
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
update intakeservicerequest 
set actiontype = 'IR', 
    intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', 
    updatedon = now(),
    updatedby = 'CDM-32017' 
where intakeserviceid = '39d625dd-5f08-48d2-b473-c3b62e6f9c01';

update intakeservicerequestsdm 
set isir = true, 
    updatedon = now(),
    updatedby = 'CDM-32017' 
where intakeserviceid = '39d625dd-5f08-48d2-b473-c3b62e6f9c01';

update personprogramarea set subprogramkey ='IR',updatedby ='CDM-32017',updatedon =now() where entityid = '231020475215'and activeflag = 1;