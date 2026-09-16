/*
   Issue Description: CJAMS-68928
   Category/ Module  : Approval Inbox
   Root cause: user wants to remove approvals from pending tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update routing 
set activeflag = 0, updatedby = 'CJAMS-68928', updatedon = now()
where tosecurityusersid ='55cc5a5b-e268-4316-bffd-26e086d57285' and activeflag = 1 and objectid in ('4079398d-9bcd-446d-b95d-44e179d2d384','1261daae-b1ee-4290-ac65-5c4a9e445038','9c5cf47d-7f2c-4f9b-a7ce-b8610d660c4a','b739de87-bf44-4e64-a5d2-056fa8d1eb29');