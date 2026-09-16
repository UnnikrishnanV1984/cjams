/*
   Issue Description: CDM-31010
   Category/ Module  :Approval inbox
   Root cause: user want to remove case from the user pending approval dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set activeflag=0 ,updatedby = 'CDM-31010', 
updatedon = now() where activeflag=1 and  routingid in ('d30e0e89-3332-4431-ba41-86b218bc9152','ad20f405-951f-4047-8afd-a629658905cb','d226593e-b748-4d3a-a665-dd4ea0eb0a82',
'200f90fb-65e0-4b49-b464-827b93ea2a03','4308602f-5560-4e45-b310-c52a5bc3d6ff','13c4bacb-f245-4d6b-938d-2f8af1f62924','f1a37986-b248-494a-bbc7-fe964e93c19d',
'870f9f45-b5b9-492e-a803-3d5de83d5d88','8cc64f81-9793-40ee-ae74-24aa22efd148','06b7c872-c2e3-44fe-b6b5-82c89688eb77','cf90a1b7-7a9d-4991-b605-04041dd9630c','c82bcabb-2f2d-41e7-8d05-4f62799be437');