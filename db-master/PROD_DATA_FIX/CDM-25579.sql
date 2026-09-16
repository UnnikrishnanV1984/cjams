/*
   Issue Description:CDM-25579
   Category/ Module  : Personprogramarea 
   Root cause: user enter wrong selection and it was closed case
   Reason why no related code fix: web fix already raised 
*/


update cjams.personprogramarea set updatedby ='299210ac-c6df-4985-a02b-bdeda0cdad67', updatedon = now()

where personprogramid  in('42e0efee-d9c0-49f9-978d-684c3efd5dc6','c770ffd6-7a3d-4f74-925e-86550f3ac37c');