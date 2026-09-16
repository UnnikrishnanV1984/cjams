/*
   Issue Description: CDM-31849
   Category/ Module  :  delete service case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/

update servicecase set activeflag = 0, updatedby = 'CDM-31849', updatedon = now()
where servicecaseid = '9599d2e0-d3fe-4e1d-9825-6243fca03263';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-31849' 
where servicecasedispositionid = 'e9c07a76-8a60-4408-bd34-3f233abf8377';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-31849' 
where routingid ='f0d5c89e-a500-4c50-9a01-279a854c1c20';
