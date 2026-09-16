/*
   Issue Description: CDM-21853
   Category/ Module  : Addition of End date
   Root cause: Unable to end date child responsibility due to the child not selected. Can't add a new person so we are unable to do anything with end dating child assignment.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/



update caseassignment  set enddate = '2021-12-21 00:00:00', updatedby = 'CDM-21853',updatedon = now()
where caseassignmentid = '479a7f44-8db9-457d-a910-0aa0951c6ec1';