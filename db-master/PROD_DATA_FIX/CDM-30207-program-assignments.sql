/*
   Issue Description: CDM-30207
   Category/ Module  : program Assignment updated by
   Root cause: user wants change the program assignment updated by
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix and code fix.
*/

update personprogramarea 
set updatedby = '12d0df4a-9b22-4f4d-a654-f8ecbbb5f85f', updatedon = now()
where personprogramid = 'd849d570-1cb0-42dd-bf36-151b10288e57';