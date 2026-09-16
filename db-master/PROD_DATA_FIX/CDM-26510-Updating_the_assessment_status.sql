/*
   Issue Description: CDM-26510
   Category/ Module  : Changing the Assessment Status to approved 
   Root cause: Assessment approved but still appearing.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update assessment set assessmentstatustypekey = 'Accepted' where assessmentid='31b7e9dc-70d8-462e-8e83-72ec201e8662';