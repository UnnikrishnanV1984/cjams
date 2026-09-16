/*
  Issue Description:  CDM-43640
   Category/ Module  :  Approval
   Root cause: re-route the subsidy rate approvals to Stephanie Mayer (SMeyer) instead of Sandra Stewart
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update routing set tosecurityusersid  = 'b89bcad8-25d0-471a-bd84-47f42d81164e'
where routingid in ('39801669-7dfe-42f8-8553-bd6a833401ec','20b6f04f-4e61-497f-a03f-f8999c224c58','77ec1515-8d95-4dbb-9f5e-79e8e35edbb1',
'15481812-f416-46a8-a33d-84e5037510be','fb1e3add-a1fd-4fa4-b2fd-42b9b5f9e7f7','f8e2dac9-614e-47cb-af06-9caefce1bb1b','ed120e9c-bc64-4174-a129-f5e360f553e2',
'0a4f14fc-bab9-40d7-b3b5-837f772a92f8','2cc8b3bf-d97d-4d02-9d03-7b740b590df1')
and activeflag  = 1;