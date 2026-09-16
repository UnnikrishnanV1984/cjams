/*
   Issue Description: CDM-21938
   Category/ Module  : Remove service case
   Root cause: user created in error so delete service case
   Pull request# for code fix: 5311
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase set activeflag =0, updatedby = 'CDM-21938', updatedon = now() 
where servicecaseid = 'c0e9a374-a4d2-437d-b87b-f92a15d054fe';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-21938', updatedon = now() 
where servicecaseid = 'c0e9a374-a4d2-437d-b87b-f92a15d054fe';
