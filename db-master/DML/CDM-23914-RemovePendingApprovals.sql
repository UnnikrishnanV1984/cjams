/*
   Issue Description: CDM-23914
   Category/ Module  : Removing Pending Approvals from the list
   Root cause: Removing Pending Approvals from the list
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

delete from routing where routingid in ('757b179b-6473-499b-823a-f5f773a116e0', '140bc532-a7f4-4e8f-b870-c73aabeae856',
'1a886ef4-c190-42db-bb8f-66a9dafe0867', 'e51a683e-76e0-40b5-ac7e-ad912ec153f3',
'6c9ea4f8-2241-4c2f-b8a3-7033eb5d3fa1',  '2bd5d380-16c5-469b-ade8-42f733689f35',
'02c23d10-fe67-48b6-b17a-9e264efc55ef', 'afcb88b3-d68b-43ef-8ebc-6296c65a997e');

update routing set activeflag = 1, updatedby = 'CDM-23914', updatedon = now()  where routingid in ('f55110fe-72b5-4731-98b3-97f2e628763c');