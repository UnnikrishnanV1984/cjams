/*
   Issue Description: CJAMS-67148
   Category/ Module  : Prod data fix to remove incorrect SEN Request removals
   Root cause: CDM-44800
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update person set senstatusflag = 0, updatedby = 'CJAMS-67194', updatedon = now()
where cjamspid = '204721851' and senstatusflag = 1;