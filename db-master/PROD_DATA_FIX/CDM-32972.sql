/*
 Issue Description: CDM-32972
   Category/ Module :adoption program assignment
   Root cause: user wants to update  end date and updatedby the adoption program assignment with 07/14/2023 ans Cassie Yates (cassie.yates@maryland.gov)
   Pull request# for code fix: 
   
*/

update personprogramarea set enddate='2023-07-14 00:00:00' ,updatedby='f26c03d5-e415-4b8e-86d9-f3f8155f4015' ,updatedon=now()
where personprogramid='7804e186-20cd-4355-b60a-48988e51e7b7' and activeflag=1;