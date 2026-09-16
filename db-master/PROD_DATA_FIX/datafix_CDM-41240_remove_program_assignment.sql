-- CDM-41240 - remove program assignment

/*
-- Issue Description: 
   User request to update remove the AXYS Program Assignment 
-- "casenumber": "241030254385", "programname": "Auxiliary Services", "subprogramkey": "CMP", personprogramid : 'c6273d03-2fb1-49ff-adbb-07dfc8f9d622'

-- Category/ Module: Person Programs
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to remove Program Assignment for casenumber 241030254385
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/


update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-41240'
where personprogramid = 'c6273d03-2fb1-49ff-adbb-07dfc8f9d622';