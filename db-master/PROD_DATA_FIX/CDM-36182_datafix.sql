-- CDM-36182- Wrong start date for program assignment
/* 
-- Issue Description: 
   User request to change the program assignment start Date 
   Need to update the start date from 07/24/2023 to 06/26/2019
   
-- Case ID: 3285380 - 7ae2cd72-3d80-446d-8005-64a505e2ecb0
-- Client ID: 1440005  (Larry Barnes) - e1685797-60b3-4b87-9163-5a2c830462cd

-- Category/ Module: Program Assignment

-- Root cause: Program Assignment start date was not correct per user
-- Fix Provided: Datafix has been updated to update the Program Assignment start date
-- Pull request# N/A
*/


select * from personprogramarea where personprogramid = '62b913ed-46d9-47c3-a404-10feb6d00c8f';

update personprogramarea 
set startdate = '2019-06-26 00:00:00',
updatedby = 'CDM-36182',
updatedon = now()
where personprogramid = '62b913ed-46d9-47c3-a404-10feb6d00c8f';