/*
 Issue Description: CDM-40051
-- Category/ Module: Case Worker Dashboard/ Persons / Program Assignments
-- Root cause: Change start date and end date for OOH.
-- Fix Provided: Datafix has been promoted to update the start date and end date.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea 
set startdate  = '04/27/2023',
	enddate='05/10/2024',
	updatedon=now(),
	updatedby='CDM-40051' 
where 
    personprogramid='be051e38-4747-4d1d-ae03-ed1f17a10c5a';

