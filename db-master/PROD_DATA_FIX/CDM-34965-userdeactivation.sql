
/*
  Issue Description:CDM-34965 Names in CJAMS that need to be removed: Somerset Co.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'jim.coburn@maryland.gov AND cathleen.barefoot@maryland.gov'
-- id : 3950,12939

update userprofile set activeflag = 0, updatedby = 'CDM-34965', updatedon = now() 
where securityusersid in ('404370df-d3c7-438f-a735-680dd827c727' ,'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-34965', updatedon = now() 
where securityusersid in ('404370df-d3c7-438f-a735-680dd827c727' ,'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9')  and activeflag = 1;
update cjams.securityusers set  activeflag=0, updatedby='CDM-34965', updatedon=now()  
where securityusersid in ('404370df-d3c7-438f-a735-680dd827c727' ,'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9') and activeflag = 1;
update cjams.teammemberassignment set  activeflag=0, updatedby='CDM-34965', updatedon=now() 
where securityusersid in ('404370df-d3c7-438f-a735-680dd827c727' ,'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-34965', updatedon = now() 
where principalid in ('3950','12939') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-34965', updatedon = now() 
where userid in (3950,12939) and activeflag = 1;

