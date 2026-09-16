/*
   Issue Description: CDM-33013
   Category/ Module  :  Service Plan
   Root cause: user wants to update the Supervisor name as the approved by
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/


update snapshothist set updatedby='0d221a83-4a79-47b0-9e9a-ec7dccaa8844' 
where id in ('fa6bd3ca-05f3-4905-8e51-27997907e7e3','a45f4cf7-9bb2-48a3-b746-37751c4ba1a9');