/*
   Issue Description: CDM-30203
   Category/ Module  : Assignments
   Root cause: user wants to remove the wrong assignment count 
   Pull request# for code fix: 8611
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update caseassignment 
set activeflag =0,
updatedby ='CDM-30203',
updatedon = now() 
where toworkeridno ='c078eed8-fab6-490d-b099-47f9b968a5dc' and 
enddate is null
and activeflag = 1 
and objectid in('845ec38a-028a-4724-9e3f-010112cd15e5' , '8e69d627-6ce8-4eb8-ae7a-a9f634173ecb','bf05236b-d3d4-4eac-912c-7c5b005c64bd', 'd5a7ec54-8798-4586-a432-43786325fa4f');

update caseassignment 
set activeflag =0,
updatedby ='CDM-30203',
updatedon = now() 
where toworkeridno ='5c38882f-227a-49ee-b516-b6a87dbc5b0a' and 
enddate is null
and activeflag = 1 
and objectid in('0cd60b06-60f8-49eb-a775-9b457d84d7b5','196bdd00-50d6-4c64-ae39-11f05ddc6c64','12b3be07-9e5f-40b6-b89f-e4088720c30a','693bc51a-f373-441e-9d32-6f3732f19fa3','98332a02-92b1-4917-8966-e3730a61c6e1','cc7a48b4-dc1d-4321-ac2b-013749c871e5');