/*
-- Issue Description: 
-- Category/ Module: Remove the case
-- Root cause: data fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update servicecase set activeflag = 0, updatedon = now(), updatedby = 'CDM-30189' 
   where servicecaseid = 'f83102bf-f473-45a7-83f9-b5119ccf7507';

---servicecase Disposition removal
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-30189', updatedon = now() 
where servicecaseid = 'f83102bf-f473-45a7-83f9-b5119ccf7507';

---caseassignment removal
update caseassignment set activeflag = 0, updatedby = 'CDM-30189', updatedon = now() 
where objectid = 'f83102bf-f473-45a7-83f9-b5119ccf7507' and activeflag = 1 ;

--routing removal
update routing set activeflag = 0, updatedby = 'CDM-30189', updatedon = now() 
where objectid = 'f83102bf-f473-45a7-83f9-b5119ccf7507';