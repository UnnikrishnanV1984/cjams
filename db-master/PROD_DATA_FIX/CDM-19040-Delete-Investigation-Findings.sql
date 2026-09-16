/*
   Issue Description: CDM-19040
   Category/ Module  : Investigation finding
   Root cause: User requested to remove findings which are under maltreator role
   Pull request# for code fix: 7371
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix
*/
update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-27574' 
where maltreatmentid in ('152c1964-1e77-44cb-bbe2-10f04ea45f40', '47de1e73-c36a-4685-9078-714501f6e48a', '31b22d63-9e44-4ce0-957c-e012b78cd6e5');