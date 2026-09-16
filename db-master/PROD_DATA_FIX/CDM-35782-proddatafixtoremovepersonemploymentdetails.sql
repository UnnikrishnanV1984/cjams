/*
   Issue Description: CDM-35782
   Category/ Module  : Prod data fix to update to remove person employment details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personemployment set activeflag = 0, updatedon = now(), updatedby = 'CDM-35782'
where personemploymentid  = '8a3074a2-0384-4e4f-880d-a378ba18b297' and activeflag = 1;