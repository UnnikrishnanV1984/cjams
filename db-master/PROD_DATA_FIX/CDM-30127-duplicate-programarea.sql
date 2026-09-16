/*
   Issue Description: CDM-30127
   Category/ Module  : Person - Program area
   Root cause: User wants remove the duplicate entry from person program area
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea 
set activeflag = 0, 
updatedon = now(), 
updatedby = 'CDM-30127'
where personprogramid ='335496f9-8c2e-4d01-baec-2f8019b63d94';

update personprogramarea set startdate = '2021-09-14 00:00:00', updatedby = 'CDM-30127', updatedon = now() 
where personprogramid = 'dec2b59a-9479-4716-9a48-516031c38244'; 