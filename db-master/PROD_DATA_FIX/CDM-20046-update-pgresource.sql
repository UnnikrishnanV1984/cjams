
/*
  Issue Description: CDM-20046 Access to case
   Category/ Module  :  user management
   Root cause: Use was unable to add placement because placement.add permission was not enabled in pgresource table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: false
*/
-- resourceid:'placement.placementlist.add'

update pgresource p set isenabled = true, updatedby ='CDM-20046' , updatedon = now() where permissiongroupid = '68120845-9b75-43d4-8a4a-2179d5f0fbc6' and pgresourceid = '69b7ec91-2af1-4696-a6e4-c638bfa0b329' 
and resourceid ='d922ca7c-b0c8-4a9f-957c-401032541d50';