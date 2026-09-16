/*
  Issue Description: CDM-36017
   Category/ Module  :  duplicate permanency plan removal
   Root cause: request to remove duplicate permanancy plan
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select activeflag,* from permanencyplan where permanencyplanid='5a66ebaa-7651-47fb-977e-341e1dd4074e';


update permanencyplan set activeflag = 0, updatedby = 'CDM-36017', updatedon = now() where 
permanencyplanid='5a66ebaa-7651-47fb-977e-341e1dd4074e' and activeflag=1;

update permanencyplan_history set activeflag=0, updatedby = 'CDM-36017', updatedon = now() where
permanencyplanid='5a66ebaa-7651-47fb-977e-341e1dd4074e' and activeflag=1;