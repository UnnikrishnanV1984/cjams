-- CDM-37064- Wrong start date for program assignment
/* 
-- Issue Description: 
   User request to change the program assignment start Date 
   Need to update the Auxiliary Services Program Assignment start date from 01/01/2023 to 01/30/2023
   
-- Case ID: 3293266 - 16b741f2-7bd2-45ca-9603-87643d132603
-- Client ID: 4300597 (DYLAN JACKSON) - 7c0410ff-3c71-4c2d-95ce-d7acbf99b5bc

-- Category/ Module: Program Assignment

-- Root cause: Program Assignment start date was not correct per user
-- Fix Provided: Datafix has been updated to update the Program Assignment start date
-- Pull request# N/A
*/


select * from personprogramarea where personprogramid = '12390530-3a0f-47e6-a708-82133bd55c79';

update personprogramarea 
set startdate = '2023-01-30 00:00:00',
updatedby = 'CDM-37064',
updatedon = now()
where personprogramid = '12390530-3a0f-47e6-a708-82133bd55c79';