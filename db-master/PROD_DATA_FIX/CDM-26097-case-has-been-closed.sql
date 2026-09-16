/* 
 Issue Description: CDM-26097
 Category/ Module  : Case has been closed
 Customer Email ID: meghan.dibenedetto@maryland.gov
 Root cause:  Work load status is set to closed  and also end date is updated in Assignments.
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update caseassignment set enddate = '2022-09-12 14:09:00', updatedby = 'CDM-26097',updatedon = now()
where caseassignmentid = '4e65663e-4f43-49bd-968e-8feca8f1ed7d';