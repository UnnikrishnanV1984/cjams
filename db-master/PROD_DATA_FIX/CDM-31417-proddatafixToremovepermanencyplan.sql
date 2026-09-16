/*
   Issue Description: CDM-31417
   Category/ Module  : Prod data fix to remove permanency plan 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update permanencyplan set activeflag = 0 , updatedby = 'CDM-31417', updatedon = now()
where permanencyplanid in ('84cf66dc-8dcc-4efd-9f8f-45eff23b2c64','3d479b0f-406c-40dd-b0d3-f9d09d949a4b') and activeflag = 1;
 

update permanencyplan set concurrentpermanencytype = null, updatedby = 'CDM-31417', updatedon = now()
where permanencyplanid in ('f2bc0744-63be-4eb0-9be6-fe66a7ff9798') and activeflag = 1;
