/*
   Issue Description: CDM-26002
   Category/ Module  : Prod data fix to update user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.personprogramarea set updatedby ='299210ac-c6df-4985-a02b-bdeda0cdad67', updatedon = now()

where  personprogramid ='23358250-bd7f-4735-a77f-e21042236b49';