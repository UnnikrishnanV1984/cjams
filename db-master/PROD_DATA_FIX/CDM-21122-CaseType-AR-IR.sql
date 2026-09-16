/*
   Issue Description: CDM-21122
   Category/ Module  : Change case type
   Root cause: user wants chnage the case AR TO IR
   Pull request# for code fix: 5206, 5221
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakeservicerequest 
set actiontype = 'IR', 
    intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', 
    updatedon = now(),
    updatedby = 'CDM-21122' 
where intakeserviceid = '55df0a23-0996-424b-990d-b805ec2e169a';

update intakeservicerequestsdm 
set isir = true,
     isar = false, 
    updatedon = now(),
    updatedby = 'CDM-21122' 
where intakeserviceid = '55df0a23-0996-424b-990d-b805ec2e169a';