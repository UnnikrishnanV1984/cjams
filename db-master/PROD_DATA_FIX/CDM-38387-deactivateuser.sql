
/*
  Issue Description:CDM-38387 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'lauren.brewer@maryland.gov'
-- id : 9908

update userprofile set activeflag = 0, updatedby = 'CDM-38387', updatedon = now() 
where securityusersid in ('35ad4efd-17d9-495d-a53d-b61bbd7bfa5e') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-38387', updatedon = now() 
where securityusersid in ('35ad4efd-17d9-495d-a53d-b61bbd7bfa5e')  and activeflag = 1;
update cjams.securityusers set activeflag=0, updatedby='CDM-38387', updatedon=now()  
where securityusersid in ('35ad4efd-17d9-495d-a53d-b61bbd7bfa5e') and activeflag = 1;
update cjams.teammemberassignment set activeflag=0, updatedby='CDM-38387', updatedon=now() 
where securityusersid in ('35ad4efd-17d9-495d-a53d-b61bbd7bfa5e') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-38387', updatedon = now() 
where principalid in ('9908') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-38387', updatedon = now() 
where userid in (9908) and activeflag = 1;

