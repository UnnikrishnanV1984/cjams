/*
-- Issue Description: 3047810:Case is stuck and unable to be closed. Please end date the worker assignment with 06/24/2022.  
-- Root cause: Change requested by user.
-- Fix Provided: Updated case assignment table with new end date.
*/

update caseassignment
set enddate = '2022-06-24', updatedby = 'CDM-38953', updatedon = now()
where caseassignmentid = 'd209a414-3976-4937-951e-4cc4f8ebe66b';