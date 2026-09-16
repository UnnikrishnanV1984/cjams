
/*
   Issue Description: CDM-33216
   Category/ Module  :  Service Plan versions
   Root cause: user wants to update  Service Plan versions approved by name
   Fix Provided: Removing the person from case .
   --intakeserviceid='26ee536d-a136-4946-9b34-58a53960cf30'
*/
update actor set intakeserviceid=null where 
actorid='866c06a6-b1ff-4fbd-ba5f-e41a0ab6dfa5';
update intakeservicerequestactor set intakeserviceid=null  where 
actorid='866c06a6-b1ff-4fbd-ba5f-e41a0ab6dfa5';