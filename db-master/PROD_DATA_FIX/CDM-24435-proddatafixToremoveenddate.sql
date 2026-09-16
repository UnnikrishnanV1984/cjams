/*
   Issue Description: CDM-24435
   Category/ Module  : Prod data fix to screenout Intake
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--2021-06-21 00:00:00	2022-05-12 00:00:00
update personprogramarea set startdate = '2021-06-20 00:00:00', enddate = null, updatedon = now(), updatedby = 'CDM-24435' where
personprogramid = 'df5aa2cf-ea84-4da5-8d91-addce9c9dddb';
--2022-05-12T13:30:26
update intakeservreqchildremoval set exitdate = null, updatedon = now(), updatedby = 'CDM-24435' where
intakeservreqchildremovalid  = '244c48b7-e6d3-40c7-a337-1a9d12a699ae';