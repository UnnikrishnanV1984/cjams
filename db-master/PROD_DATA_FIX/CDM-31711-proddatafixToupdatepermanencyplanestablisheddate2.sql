/*
   Issue Description: CDM-31711
   Category/ Module  : Prod data fix for updating permanency plan
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--Daysaun Jones - PID 3473705 - Start date - 8/15/2018
--Ernest Jones - PID 3660361 - Start date - 8/15/2018
update permanencyplan set establisheddate = '2018-08-15 05:00:00', updatedon = now(), updatedby = 'CDM-31711'
where permanencyplanid in ('9beb87fa-ceaa-4292-8ca1-3f285976941f','cfbbe35e-f6ab-4fd2-933b-02f69500e9e9');

