/*
-- CDM-25337 - 
-- Issue Description: Wrong Staff Identified 
   
-- Customer Email ID: susan.loysen@maryland.gov

-- Root cause: Data fix updated the updatedby 

Data backup
--Personprogramid 								updated by
--b9b84f71-9d5f-4112-8ddd-014a811f4b20		05348cfc-3a12-48be-b3da-a494373b1b56

*/

update personprogramarea set updatedby = '4103969d-6c19-4065-8d86-fa7706680634', updatedon = now() where personprogramid = 'b9b84f71-9d5f-4112-8ddd-014a811f4b20';