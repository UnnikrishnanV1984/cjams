
/*
 Issue Description: CDM-40257
-- Category/ Module: Case closure
-- Root cause: User requested to remove record from workload grid
-- Fix Provided: Datafix has been promoted to update flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update  cjams.caseassignment 
set enddate = '2024-07-05',
    updatedon = now(), 
    updatedby = 'CDM-40257'
where caseassignmentid ='9b5d547d-3cf7-472b-97cd-b679366b0818'
