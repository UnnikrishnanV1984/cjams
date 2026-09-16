/*
   Issue Description: CDM-42772
   Category/ Module  :  Case assignemnt
   Root cause: On case closure assingmetn end date is not updating 
   Pull request# for code fix: 
   Reason why no related code fix: Couldn't reproduce the issue in local env.
 
*/

update caseassignment
set enddate ='2024-11-14', updatedon = now(), updatedby  = 'CDM-42772'
where objectid ='f139e8ea-2f16-42f5-8a7a-9f6d583df41a' 
and caseassignmentid ='289440ee-5ad5-44f0-a593-a345292e5ae1';