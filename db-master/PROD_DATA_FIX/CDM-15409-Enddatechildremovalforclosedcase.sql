
/*
   Issue Description: CDM-15409
   Category/ Module  :  Updating Draft Removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set exitdate = '2020-06-19 00:00:00',removalexitreason = 'EMANIND', updatedon = now(), updatedby = 'CDM-15409' where intakeservreqchildremovalid = '852f40bc-a333-4d99-8457-5afda1d339a7';
-- 2020-07-20 08:52:56
update personprogramarea set enddate = '2020-06-19 00:00:00', updatedon = now(), updatedby = 'CDM-15409'where personprogramid = 'ccb94553-b7c5-4b03-98c3-a4aa30fc8e4e';
