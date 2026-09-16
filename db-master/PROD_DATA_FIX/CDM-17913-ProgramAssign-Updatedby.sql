/*
   Issue Description: CDM-17913
   Category/ Module  :  Updated by in program assignments
   Root cause: user asked to change updated by 
   Pull request# for code fix: 7329
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need data fix.
*/
update personprogramarea 
set updatedby = '567a5417-ee3f-4bd7-a975-5f6488d0b3e4', updatedon = now()
where personprogramid = '77b1b278-1b3d-4405-95b8-91a877379bd2';