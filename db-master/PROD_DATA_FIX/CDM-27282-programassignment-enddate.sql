/*
   Issue Description: CDM-27282
   Category/ Module  : program assignment
   Root cause: user wants to  update OOh enddate
   Pull request# for code fix: 7182
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update personprogramarea 
set enddate = '2022-11-16 10:46:19',
updatedby = 'CDM-27282',
updatedon = now()
where personprogramid ='f4766e68-a8a4-419c-8b8f-f3e6645cfcd6';