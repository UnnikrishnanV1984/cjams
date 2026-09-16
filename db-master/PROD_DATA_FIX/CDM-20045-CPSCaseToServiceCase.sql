/*
   Issue Description: CDM-20045
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4756, 4767
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservicerequest 
set servicecaseid = 'c4953e1f-4d05-4e93-b3b5-c9bffb5ec1b1', updatedby = 'CDM-20045', updatedon = now()
where intakeserviceid = '96cbd402-ea84-4dea-a9ca-748e6641f732';

update servicecase set activeflag =0, updatedby = 'CDM-20045', updatedon = now() 
where servicecasenumber = '221030013789' and activeflag =1;

update intakeservicerequestactor set servicecaseid = 'c4953e1f-4d05-4e93-b3b5-c9bffb5ec1b1', updatedby = 'CDM-20045', updatedon = now() 
where servicecaseid = '6c8b795f-f7c6-4d19-9131-4649fb6abd29' 
and intakeserviceid = '96cbd402-ea84-4dea-a9ca-748e6641f732';

update actor set servicecaseid = 'c4953e1f-4d05-4e93-b3b5-c9bffb5ec1b1',
updatedby = 'CDM-20045', updatedon = now() where servicecaseid = '6c8b795f-f7c6-4d19-9131-4649fb6abd29' 
and intakeserviceid = '96cbd402-ea84-4dea-a9ca-748e6641f732';
