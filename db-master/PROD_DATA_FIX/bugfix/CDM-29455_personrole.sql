/*
   Issue Description: CDM-29455
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29455'
where personroleid in ('bb57b775-2894-4293-be5c-fff7cef6e17f',
'9fdbcd7e-0643-4245-a5d1-21fd48bf3c13', '9ddca680-8911-49c7-b64b-6763726e6201','814cfdcc-fe8e-4478-b0d0-79cf0217883e',
'0c5cda08-a34e-40cb-98d9-604f347eb820','4e8e3c03-305c-4ac1-bae5-8bafed385499','44d2b3ec-afbc-486d-a2ff-fa20a5a08bf8',
'277c3a28-8df2-4303-9a22-c2c3c1b857fe','ecab6dc3-fb51-48fc-8df8-499745e99b8b','4ceb4605-c5ca-4afc-b37d-06ced7509de1',
'1084f2fc-996d-4aa7-8817-e6bbd0119734','7fddcf25-e853-4591-b6b3-8f29df0cbe9d','1f9a096c-bf97-4437-89d3-74942cac755e')