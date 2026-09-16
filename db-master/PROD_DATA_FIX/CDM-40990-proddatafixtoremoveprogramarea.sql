/*
   Issue Description: CDM-40990
   Category/ Module  : Prod data fix to update to remove Person program area
   Root cause: Data fix to remove person program area
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personprogramarea set activeflag = 0 ,  updatedby = 'CDM=40990' , updatedon = now()
where personprogramid in  ('e6e8f876-3b18-4a3e-8b7f-c5b323a3f9d0',
'64418f1b-774d-47ec-a4ea-b7dbba616124',
'73fb2fca-eff0-42b7-9a03-634b6965f6a5',
'dedcd479-eb66-4844-9183-0004481d0914',
'e739b194-e78d-431c-b9a2-dcaa3b4378f6',
'39723e6c-21dd-4a27-8d12-cdb00613cbda',
'42519051-ae18-485f-996d-22cc9e83f0f7',
'0e0c9eef-8a2b-4f3b-8610-cd571d8639a5',
'68340b81-3e83-498b-9143-725558781e32') and activeflag = 1;