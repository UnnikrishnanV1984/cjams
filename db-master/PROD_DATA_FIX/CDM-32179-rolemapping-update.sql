/*
   Issue Description: CDM-32179
   Category/ Module  :Dashboard
   Root cause: incorrect rolemapping
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update rolemapping set roleid ='1052',updatedby ='CDM-32179' ,updatedon =now() where roleid ='1053' and principalid ='3393' and activeflag =1;



update  userresource 
set activeflag =0,updatedby ='CDM-32179' ,updatedon =now() 
where roleid ='1053' and userid ='3393'
and permissiongroupid='2a2f16c1-3c3d-48cb-93ac-fb60956fa42a'
;



update teammember set roletypekey ='FNSFW' ,updatedby ='CDM-32179' ,updatedon =now() where teammemberid = '49132568-1411-4fc9-898a-d59874e1a7e6';