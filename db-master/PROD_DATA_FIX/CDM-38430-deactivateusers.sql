
/*
  Issue Description:CDM-38430 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'jasmine.ferguson@maryland.gov',                    
-- 'julie.campos@maryland.gov',                                             
-- 'kyrstin.stalnaker@maryland.gov',                   
-- 'rachael.wallace@maryland.gov',                
-- 'candace.deshields@maryland.gov'
-- id : 9546,9679,14906,22777,27189

update userprofile set activeflag = 0, updatedby = 'CDM-38430', updatedon = now() 
where securityusersid in ('11267bd2-d9cb-4ce0-8a1d-9614c603d774','bbdb160d-8669-4ce1-b6fb-d3e72a2a692c',
'16bf7602-5b85-460e-af93-b7218d70aaa8','cf65ee83-ac81-4553-9e4c-86bcb8c18cfc','a3003b15-0e18-47a8-b691-5c36972144bf') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-38430', updatedon = now() 
where securityusersid in ('11267bd2-d9cb-4ce0-8a1d-9614c603d774','bbdb160d-8669-4ce1-b6fb-d3e72a2a692c',
'16bf7602-5b85-460e-af93-b7218d70aaa8','cf65ee83-ac81-4553-9e4c-86bcb8c18cfc','a3003b15-0e18-47a8-b691-5c36972144bf')  and activeflag = 1;
update cjams.securityusers set activeflag=0, updatedby='CDM-38430', updatedon=now()  
where securityusersid in ('11267bd2-d9cb-4ce0-8a1d-9614c603d774','bbdb160d-8669-4ce1-b6fb-d3e72a2a692c',
'16bf7602-5b85-460e-af93-b7218d70aaa8','cf65ee83-ac81-4553-9e4c-86bcb8c18cfc','a3003b15-0e18-47a8-b691-5c36972144bf') and activeflag = 1;
update cjams.teammemberassignment set activeflag=0, updatedby='CDM-38430', updatedon=now() 
where securityusersid in ('11267bd2-d9cb-4ce0-8a1d-9614c603d774','bbdb160d-8669-4ce1-b6fb-d3e72a2a692c',
'16bf7602-5b85-460e-af93-b7218d70aaa8','cf65ee83-ac81-4553-9e4c-86bcb8c18cfc','a3003b15-0e18-47a8-b691-5c36972144bf') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-38430', updatedon = now() 
where principalid in ('9546','9679','14906','22777','27189') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-38430', updatedon = now() 
where userid in (9546,9679,14906,22777,27189) and activeflag = 1;

