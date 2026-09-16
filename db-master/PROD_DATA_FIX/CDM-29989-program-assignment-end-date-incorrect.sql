/*
   Issue Description: CDM-29989
   Category/ Module  : program assignment
   Root cause: user wants to  update OOh enddate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

update personprogramarea 
set enddate = '2022-04-13 00:00:00',
updatedby = 'CDM-29989',
updatedon = now()
where personprogramid ='43858d66-950c-49d4-be26-6fc2ac5751ee';