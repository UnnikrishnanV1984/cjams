
/*
   Issue Description: CDM-14928
   Category/ Module  :  Updating removal end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



-- 2021-07-01 15:00:00
update intakeservreqchildremoval set exitdate = '2021-07-09 15:00:00', updatedon = now(), updatedby = 'CDM-14928' where intakeservreqchildremovalid = '97168d1b-1ada-49ec-8d0a-d493a4fa1912';


update personprogramarea set enddate = '2021-07-09 15:00:00', updatedon = now(), updatedby = 'CDM-14928'where personprogramid = '22c7f41e-3cc1-4658-9c69-91d78f8cddf9';

