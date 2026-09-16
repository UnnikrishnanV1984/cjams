
/*
  Issue Description:CDM-38384 Terminated Worker.
  Category/ Module : user management
  Root cause: Users are still active in tables
  Pull request# for code fix: 
  Reason why no related code fix:
  Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 1
*/
-- email:'aubree.savoy@maryland.gov'
-- id : 14525

update userprofile set activeflag = 0, updatedby = 'CDM-38384', updatedon = now() 
where securityusersid in ('2b30457e-778c-43a8-88a1-7c80c41092d8') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-38384', updatedon = now() 
where securityusersid in ('2b30457e-778c-43a8-88a1-7c80c41092d8')  and activeflag = 1;
update cjams.securityusers set activeflag=0, updatedby='CDM-38384', updatedon=now()  
where securityusersid in ('2b30457e-778c-43a8-88a1-7c80c41092d8') and activeflag = 1;
update cjams.teammemberassignment set activeflag=0, updatedby='CDM-38384', updatedon=now() 
where securityusersid in ('2b30457e-778c-43a8-88a1-7c80c41092d8') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-38384', updatedon = now() 
where principalid in ('14525') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-38384', updatedon = now() 
where userid in (14525) and activeflag = 1;

