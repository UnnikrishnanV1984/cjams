/*
   Issue Description: CDM-25835
   Category/ Module  : Remove service case
   Root cause: user created in error so delete service case
   Pull request# for code fix: 5311
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase set activeflag =0, updatedby = 'CDM-25835', updatedon = now() 
where servicecaseid = '9ec5a939-6600-4692-9898-63a0f152f41d';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-25835', updatedon = now() 
where servicecaseid = '9ec5a939-6600-4692-9898-63a0f152f41d';
