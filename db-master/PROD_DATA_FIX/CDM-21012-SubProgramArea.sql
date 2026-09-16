/*
   Issue Description: CDM-21012
   Category/ Module  : Program Assignments 
   Root cause: user accidently saved the program assignment without adding the program sub area
   Pull request# for code fix: 7306
   Reason why no related code fix: its user mistake
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update personprogramarea set subprogramkey = 'SFCI', updatedby = 'CDM-21012', updatedon = now() 
where personprogramid = '080681ce-e632-4921-8a92-615a35c126dc';

update personprogramarea set subprogramkey = 'SFCI', updatedby = 'CDM-21012', updatedon = now() 
where personprogramid = '2e06fe2a-ec03-476c-8d87-e690fa5f83e2';