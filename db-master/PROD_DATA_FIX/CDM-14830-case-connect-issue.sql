/*
   Issue Description: CDM-14830
   Category/ Module  :  child welfare - Case Connect 
   Root cause: User error case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/

select * from cjams.createservicecase('9bc868e3-8a1f-4d34-bcb7-275762ba56c0','755e34fe-c4d2-485d-af8d-fba44148552b', 0, '72439d81-dfaa-46d0-a372-f90eb16f75fd', 'intake');


update cjams.servicecase set activeflag = 0, updatedby = 'CDM-14830', updatedon = now()  where servicecasenumber = '211030008354';