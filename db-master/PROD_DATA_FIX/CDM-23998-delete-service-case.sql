/*
   Issue Description: CDM-23998
   Category/ Module  :  delete service case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/

update servicecase set activeflag = 0, updatedby = 'CDM-23998', updatedon = now()
where servicecaseid = '1a7c5fdf-73a7-4383-ace4-bdd69b1f9fa8';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-23998' 
where servicecasedispositionid = 'c95b0d3c-cdcd-492b-9f76-ab5fa0b7e44d';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-23998' 
where routingid ='cea426f4-5009-4d90-b235-b5b0e5eb8914';
