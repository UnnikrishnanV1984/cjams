/*
   Issue Description:CDM-7914 --Placement Issue
   Category/ Module  :  Living arrangement
   Root cause: Person id and actor id mapping is issue on the intakeservicrequestactor table.Unable reproduce this in the applicatoin
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
---Old value: Personid: 67b0b567-9d15-4dd9-b20c-3f2bc2f7dc25
*/
update intakeservicerequestactor set personid='c8b8d493-7754-42b8-9e53-8057d5eb36fc',updatedby='CDM-7914',updatedon=now()
where actorid='7efa4d25-e69f-4f1a-8780-3b60a4619aa0' and servicecaseid='2a5bbc71-e9f8-4c02-b30c-f7007a2c9289' and personid='67b0b567-9d15-4dd9-b20c-3f2bc2f7dc25';

