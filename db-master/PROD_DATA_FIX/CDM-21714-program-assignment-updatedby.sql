/*
   Issue Description: CDM-23459
   Category/ Module  : program Assignment updated by
   Root cause: user wants change the program assignment updated by
   Pull request# for code fix: 7480
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix and code fix.
*/

update personprogramarea 
set updatedby = '2e996913-8c1d-4f8b-9015-d404a858ec9f', updatedon = now()
where personprogramid = '20d92b43-1ec0-482e-bf7f-38f5eaac3a5e';