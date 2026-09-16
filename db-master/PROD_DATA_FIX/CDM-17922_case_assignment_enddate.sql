/*
    Issue Description: CDM-17922
    Category/Module  : Case assignment
    Root cause: user wants to add the end date for case assignment
    Pull request# for code fix: 
*/

update caseassignment 
set enddate = '2020-06-16 00:00:00', 
    updatedby = 'CDM-17922', 
    updatedon = now() 
where caseassignmentid = 'f491d47f-01bf-4058-9a9c-c6f8ff0edf31';