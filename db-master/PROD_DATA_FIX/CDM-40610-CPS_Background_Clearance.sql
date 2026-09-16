/*
   Issue Description: CDM-40610
   Category/ Module  :  Intake / Person card
   Root cause: User error, user requested to update the date of birth of person 
   Pull request# for code fix: 
   Reason why no related code fix: 
 
*/

update person
    set dob = '1941-06-30', updatedon = now(), updatedby ='CDM-40610'
where  
   personid = 'c0fc206d-c400-44e5-9d9e-c6ca0888a6f8';

