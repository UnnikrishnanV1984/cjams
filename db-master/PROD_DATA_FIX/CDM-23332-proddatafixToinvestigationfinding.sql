/*
   Issue Description: CDM-23332
   Category/ Module  : Prod data fix to Remove Investigation findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update investigationallegation set activeflag = 0, updatedby = 'CDM-23332', updatedon = now() 
where investigationallegationid = 'e1d7f794-f058-46cb-81d3-a8db5431b123' and activeflag =1;