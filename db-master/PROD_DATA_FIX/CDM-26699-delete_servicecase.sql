/*
   Issue Description: CDM-26699
   Category/ Module  :  delete service case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/


update servicecase set activeflag = 0, updatedby = 'CDM-26699', updatedon = now()
where servicecaseid = '58948879-e9c3-4a5d-987f-bfaf135fbbc3';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-26699' 
where servicecasedispositionid = '6e420aee-a1b8-400b-8e7c-69f13d2c94ba';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-26699' 
where routingid ='def6687a-7788-4505-8e9a-a94cdb5158cd';
