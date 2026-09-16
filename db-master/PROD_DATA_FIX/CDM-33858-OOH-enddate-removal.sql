/*
   Issue Description: CDM-33858
   Category/ Module  : person program area
   Root cause: OOH enddate was wrong
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update personprogramarea 
set enddate =null ,updatedby ='CDM-33858',updatedon =now() 
where personprogramid ='0ed8bc9a-e354-4eca-992e-1c990868d6d6';