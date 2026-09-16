/*
   Issue Description: CDM-23459
   Category/ Module  : program Assignment updated by
   Root cause: user wants change the program assignment uodated by
   Pull request# for code fix: 6472
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix and code fix.
*/
update personprogramarea 
set updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67', updatedon = now()
where personprogramid = '88b88414-beb2-4dfd-bd10-a1a31aa468e6';