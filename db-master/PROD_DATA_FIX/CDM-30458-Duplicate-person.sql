
/*
   Issue Description: CDM-31074
   Category/ Module  : User wants to delete the person from case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30458'
where actorid in('9eca4084-0360-44c5-8131-4abb4a374cb5','a271e5b7-1b75-4480-b9c0-e565494e208b');

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30458'
where intakeservicerequestactorid in('7dbdc357-a387-483a-97e9-06d0f6eeee8e','b9fc94aa-a4ea-44aa-b20d-e58315aa52c4','9cad5b22-fd8d-4072-991e-4103c8d5455f','8e98115c-4b8e-4f83-90b3-0fdbf1254040') ;

update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30458'
where personroleid  in('0d7aa768-6be5-4916-80ee-499289b725e5','280ecb10-d020-4542-8f96-2f06c6cc12ee');

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30458'
where actorrelationshipid in('b1ce4699-726f-4b0f-a910-e6587900d839','5ef09fc1-591f-48ae-8ae5-b6df3b62727a','a66d8aa7-8df1-4475-9843-80279a551bbd','fc17adfc-189b-4cfb-865f-b294f85362e7') ;
