/*
  Issue Description: CDM-22182 Worker access
   Category/ Module  :  user management
   Root cause: investigation_read_only_access permissio was active for the user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
--katie.hitch@maryland.gov  14528	0457f633-bbfa-4cd3-bff2-8f013193488f


-- setting the active flag to 0 for the investigation_read_only_access perission
update userresource
set activeflag =0 ,updatedon = now(),updatedby = 'CDM-22182'
where userid=14528 and permissiongroupid='386c99fb-58ac-4d53-883c-50e65a3b285f' and activeflag=1;


update userresource 
set activeflag = 0,updatedon = now(),updatedby ='CDM-22182'
where userid = 14528 and roleid in (40,71) and activeflag = 1;

--old supervisor id = 7ca5718d-cc3f-4884-934c-6769a4d00eed
update userprofile 
set assupervisorid = 'db5ac50c-a8f4-472d-b6ee-aa47933cadda',updatedon = now(),updatedby ='CDM-22182'
where email = 'katie.hitch@maryland.gov';

-- old teamid = 015dc0c6-fcfd-4948-b53a-e266a5b8a21f
update teammember 
set teamid = '890bb836-265e-427d-bce5-9333b8071752',updatedon = now(), updatedby ='CDM-22182'
where teammemberid = 'e17d5c30-339b-42d7-aec2-b7e827b07404';