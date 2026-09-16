/*
   Issue Description: CDM-31142
   Category/ Module  : 
   Root cause: user want to update Person id with Person ID 201238123 on Contact Note 10767064
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update contactparticipant set   intakeservicerequestactorid='8aa0d2fb-bc0c-4198-affc-520819f484c0',updatedby='CDM-31142',updatedon=now()
where contactparticipantid='8d59ea43-d076-42af-9312-741fa0883cca';

update actor set activeflag=0,updatedby='CDM-31142',updatedon=now() where actorid='14523463-2244-4a49-b179-5f7858b87d24';

update intakeservicerequestactor set activeflag=0,updatedby='CDM-31142',updatedon=now() 
where intakeservicerequestactorid in ('06cd32ef-738a-47e5-8b2d-4b3db7217d8c','e18e6ebb-b973-498c-be16-a1e5bb394594');
