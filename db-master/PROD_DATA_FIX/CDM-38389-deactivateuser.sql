
/*
  Issue Description:CDM-38389 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'caroline.sprow@maryland.gov'
-- id : 14030

update userprofile set activeflag = 0, updatedby = 'CDM-38389', updatedon = now() 
where securityusersid in ('4b15b21b-243e-4b94-9d91-44d22185b687') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-38389', updatedon = now() 
where securityusersid in ('4b15b21b-243e-4b94-9d91-44d22185b687')  and activeflag = 1;
update cjams.securityusers set activeflag=0, updatedby='CDM-38389', updatedon=now()  
where securityusersid in ('4b15b21b-243e-4b94-9d91-44d22185b687') and activeflag = 1;
update cjams.teammemberassignment set activeflag=0, updatedby='CDM-38389', updatedon=now() 
where securityusersid in ('4b15b21b-243e-4b94-9d91-44d22185b687') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-38389', updatedon = now() 
where principalid in ('14030') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-38389', updatedon = now() 
where userid in (14030) and activeflag = 1;

