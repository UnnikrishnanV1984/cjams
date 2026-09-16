/*
   Issue Description: CJAMS-64548
   Category/ Module  :  Case assignemnt
   Root cause: On case closure assingmetn end date is not updating 
   Pull request# for code fix: 
   Reason why no related code fix: Couldn't reproduce the issue in local env.
 
*/

update caseassignment
set enddate = '2025-11-26', updatedon = now(), updatedby ='CJAMS-64548'
where caseassignmentid ='0a7cbfbb-35de-42a9-a793-91074440349f' and activeflag = 1;