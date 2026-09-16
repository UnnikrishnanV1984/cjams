/*
   Issue Description: CDM-23318
   Category/ Module  :  person
   Root cause: user requeseted to change the startdate 
   Pull request# for code fix: 
   Reason why no related code fix: user error
*/



update cjams.personprogramarea set startdate ='2022-04-20 00:00:00', updatedon=now()

where personprogramid ='5920de6d-969b-4f41-bb29-7d342ff70dcd';