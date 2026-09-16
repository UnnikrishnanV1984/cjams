/*
   Issue Description: CDM-26128
   Category/ Module  : Prod data fix to update user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix already done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.personprogramarea set updatedby ='299210ac-c6df-4985-a02b-bdeda0cdad67', updatedon = now()

where  personprogramid ='54299b3a-3ad8-4b80-9c7f-85a41f438f10';