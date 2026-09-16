
/*
   Issue Description: CDM-25416
   Category/ Module  : permanencyplan 
   Root cause: user requested remove the permanency plan end date and record 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.permanencyplan set activeflag =0, updatedby ='CDM-25416', updatedon =now()
where permanencyplanid ='13a99743-2316-47ed-bddd-f3f056aa076d';


update cjams.permanencyplan set enddate =null, updatedby ='CDM-25416', updatedon =now()
where permanencyplanid in('ec8d6bb9-50fd-4b19-ba5b-fd7b81b97b7c','1dff474a-9830-4f68-9fde-78502197c9af','594a6ff1-2cc9-4ec1-af69-a83da6d12e78');
