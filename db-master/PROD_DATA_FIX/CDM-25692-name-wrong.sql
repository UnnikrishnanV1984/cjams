/*
   Issue Description: CDM-25692
         Category/ Module  : program assignment
   Root cause: user wants to change the  updated by
   Pull request# for code fix: 6535
  explanantion: user wants to remove
  */


update personprogramarea 
set updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67' ,
updatedon = now()
where personprogramid = '9b606000-adf4-4bc5-8a2f-f56aa71bd586' and personid ='05271e37-eed9-4e1d-a8ab-a7bfbc40d022';