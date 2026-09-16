/*
 Issue Description: CDM-32981
   Category/ Module :adoption program assignment
   Root cause: user wants to update  end date and updatedby the adoption program assignment with 07/17/2023 and Jessica Reading (jessica.cruz@maryland.gov)
   Pull request# for code fix: 
   
*/

update personprogramarea set enddate='2023-07-17 00:00:00' ,updatedby='656f3cd7-0d2f-4ee5-978f-42a3bc1753bf' ,updatedon=now()
where personprogramid='64e331ca-f791-4b8e-9aa6-ef634fbdf696' and activeflag=1;