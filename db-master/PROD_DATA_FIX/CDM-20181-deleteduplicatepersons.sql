/*
   Issue Description: CDM-20181
   Category/ Module  : need to delete persons
   Root cause: user wants to remove
   Pull request# for code fix: 6508
  explanantion: user wants to remove
  */

update cjams.actor set activeflag = 0,updatedon = now(),updatedby = 'CDM-20181'
where actorid in ('a0be2df2-9ec6-4b7d-830d-508ac251591d', 'd96d53f5-71c5-488e-9c50-33d42640e82a','26782aad-d005-4962-a93c-5d44690a81a8');

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-20181'
where intakeservicerequestactorid in ('ef641863-fbcb-4077-874f-b00017df1de6', '4801da84-f18c-4ea0-85ac-155484c1ab48','f7670d8f-6f78-457d-bf8b-73bc05313e8f');

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-20181'
where personroleid in ('3bb1b24c-af65-4fed-a2bf-b3a76c67d21d', '220bbc34-1424-44ee-9239-c1f3323a6d3c','f2ca6f28-2217-4893-a640-43eaa14171b8');

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-20181'
where actorrelationshipid in ('25632ace-3b19-4511-b987-bc7ce6425e14', '1aa6a801-9844-4473-8922-956dff284c6d');

update personprogramarea set activeflag = 0 ,
updatedon = now(),
updatedby = 'CDM-20181'
where personprogramid in('666822ec-f311-432e-91f1-ad2cb73b89e9' , '89e74e15-78e2-4928-b14c-1772395f72eb','0cfa43ba-480b-44c1-b825-917d1ae76a63');