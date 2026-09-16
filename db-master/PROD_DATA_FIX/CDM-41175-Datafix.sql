/*
  Issue Description:  CDM-41175
   Category/ Module  :  Assignments
   Root cause: Request to add and remove appropriate supervisors from directors approval permission
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update userresource set activeflag = 0, updatedby = 'CDM-41175', updatedon = now()
where userresourceid  in ('0517d0e7-986a-4fb0-86a7-dbd0bd015d39','91a11371-5fec-4b61-90cf-188842c6a1b6','f098e624-32c4-40dc-ace5-5f9f662b5839') 
and permissiongroupid = '57a390b8-3387-428a-97a8-0b8559fd1f1e' and activeflag = 1 ;   
