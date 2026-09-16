/*
  Issue Description: CDM-20411 Case Assignment Capability
   Category/ Module  :  user management
   Root cause: Removing the read only access (Central policy staff)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: activeflag= 1
*/
----'cortney.carey@maryland.gov' 3293,'kyra.archie1@maryland.gov' 3298,'emmanuel.okororie@maryland.gov' 3292

update userresource set activeflag=0, updatedby='CDM-20411', updatedon= now() where userid in (3293,3298,3292) and activeflag=1
and permissiongroupid ='9f0a99a4-08ae-43ee-ba78-cb8e52a818da';
