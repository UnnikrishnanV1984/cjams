/*
-- Issue Description: 241021911317:Case is stuck and unable to be closed. Please end date the worker assignment with 2024-06-06.  
-- Root cause: Change requested by user.
-- Fix Provided: Updated case assignment table with new end date.
*/

update caseassignment
set enddate = '2024-06-06', updatedby = 'CDM-39565', updatedon = now()
where caseassignmentid = '6f4daab1-c3da-4886-97af-1fb90ef6f099';