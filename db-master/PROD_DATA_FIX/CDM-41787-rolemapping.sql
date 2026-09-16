/*
   Issue Description: CDM-41787
   Category/ Module  : User Profile
   Root cause: Recent changes in create new user module introduced this issue 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

update rolemapping rm
set teamtypekey = (select tmrt.teamtypekey from teammemberroletype tmrt 
					inner join role r on  tmrt.roletypekey = r.roletypekey and tmrt.activeflag = 1 
					where r.id = rm.roleid  and r.activeflag = 1) ,
updatedby = 'CDM-41787', updatedon = now()
where rm.teamtypekey is null and rm.activeflag = 1 and rm.insertedon > '09/16/2024';

UPDATE cjams.teammemberassignment
SET teammemberid='23397706-eb49-4f6a-aa4c-ae3a9fe4b49e', updatedby='CDM-41787', updatedon=now()
WHERE teammemberassignmentid='9a8b022d-f3cd-4591-8771-9ebb6a2cf982' and  securityusersid='582bcf97-a66f-4827-93fa-ec588ef533db';
