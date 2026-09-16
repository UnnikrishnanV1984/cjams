/*
-- Issue Description: 241021927134:Case is stuck and unable to be closed. Please end date the worker assignment with 2024-05-31.  
-- Root cause: Change requested by user.
-- Fix Provided: Updated case assignment table with new end date.
*/

update caseassignment
set enddate = '2024-05-31', updatedby = 'CDM-39344', updatedon = now()
where caseassignmentid = '6bb014db-b195-42c5-bd21-7c2a792d078e';