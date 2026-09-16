/*
-- Issue Description: 241022714884:Case unable to be closed. Please end date the worker assignment with 2024-10-02.  
-- Root cause: Change requested by user.
-- Fix Provided: Updated case assignment table with new end date.
*/
/*
select caseassignmentid, startdate, enddate,* from caseassignment c where objectid = 'd542cd8f-a477-4f42-be35-94d1e12f1a25'
*/

update caseassignment
set enddate = '2024-10-02', updatedby = 'CDM-42105', updatedon = now()
where caseassignmentid = '48f671e7-c4f6-4b21-b0aa-e7eca1979a42';