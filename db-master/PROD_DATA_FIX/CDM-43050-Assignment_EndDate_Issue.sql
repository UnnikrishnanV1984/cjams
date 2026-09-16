/*
   Issue Description: CDM-43050
   Category/ Module  :  Case assignment
   Root cause: On case closure assignment end date is not updating 
   Pull request# for code fix: 
   Reason why no related code fix: Couldn't reproduce the issue in local env and stage 3.
 
*/

update caseassignment
set enddate ='2024-11-20', 
    updatedon = now(), 
    updatedby  = 'CDM-43050'
where 
    objectid ='39965825-ec67-43b9-874d-bc0cea548fe5' 
    and caseassignmentid ='128ed344-d085-4503-913d-c7e2ebae92cf';
