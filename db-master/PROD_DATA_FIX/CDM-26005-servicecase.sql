/*
   Issue Description: CDM-26005
   Category/ Module  : Remove service case
   Root cause: user created in error so delete service case
   Pull request# for code fix: 5311
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase set activeflag =0, updatedby = 'CDM-26005', updatedon = now() 
where servicecaseid = '70319d1b-b4cb-482b-9dd2-8f6dc2017784';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-26005', updatedon = now() 
where servicecaseid = '70319d1b-b4cb-482b-9dd2-8f6dc2017784';

update cjams.routing set activeflag =0,  updatedby = 'CDM-26005', updatedon = now() 
where routingid ='4ed7e8c2-0d55-455f-a29d-ab92402343a6'