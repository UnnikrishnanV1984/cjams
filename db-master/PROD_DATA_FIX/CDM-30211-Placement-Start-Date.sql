
/*
   Issue Description: CDM-30211
   Category/ Module  : Placement
   Root cause: start date entered incorrect by user
   Pull request# for code fix: 8579
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update placement 
set startdatetime ='2022-02-28 00:00:00', updatedon =now(), updatedby ='CDM-30211'
where placementid ='e96ffdc6-bea9-4bfe-8dd1-93afc581dc8d';

update placementrevision 
set entrydate ='2022-02-28 00:00:00', updatedon =now(), updatedby ='CDM-30211'
where placementid ='e96ffdc6-bea9-4bfe-8dd1-93afc581dc8d';

update livingarrangement set livingstartdate ='2022-02-28', updatedon =now(), updatedby ='CDM-30211'
where placementid = 'e96ffdc6-bea9-4bfe-8dd1-93afc581dc8d';