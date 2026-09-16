/*
  Issue Description:  CDM-43905
   Category/ Module  :  Approval
   Root cause: re-route the subsidy rate approvals to Stephanie Mayer (SMeyer) 
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/


update routing set tosecurityusersid  = 'b89bcad8-25d0-471a-bd84-47f42d81164e',
updatedby = 'CDM-43905', updatedon = now()
where routingid in ('39801669-7dfe-42f8-8553-bd6a833401ec','2cc8b3bf-d97d-4d02-9d03-7b740b590df1','9fb65492-215d-48ba-91ff-d5afc4821538',
'c97c6359-5c22-4194-b1ef-350a277d5e75','17334bbb-c76d-4e49-b82c-22b3ac43fcdf','0a4f14fc-bab9-40d7-b3b5-837f772a92f8',
'ed120e9c-bc64-4174-a129-f5e360f553e2','f8e2dac9-614e-47cb-af06-9caefce1bb1b','fb1e3add-a1fd-4fa4-b2fd-42b9b5f9e7f7',
'15481812-f416-46a8-a33d-84e5037510be','77ec1515-8d95-4dbb-9f5e-79e8e35edbb1','c5161fe2-80b6-4899-bc44-d773ddfab5e2',
'2d921bf4-f8c3-4542-9b06-0ed97865213b','49da1c9a-bece-48ce-bf64-b03a0d8c5005')
and activeflag  = 1;