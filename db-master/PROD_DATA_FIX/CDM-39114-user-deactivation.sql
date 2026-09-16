/*
  Issue Description:CDM-39114 CJAMS Access Removal-John Shum + Chioma Adigwe.
  Category/ Module : User Management
  Root cause: Users are already deactivated in sailpoint. Please do a datafix and deactivate the below users from all user tables in cjams db
  User details
  -------------
  john.shum@maryland.gov,3ade3068-db0c-41bb-a0a0-942293ac0abd,14358 
  chioma.adigwe@maryland.gov,7f16e8da-253a-4351-a023-19f23cdfb45d,5151
  Fix Provided: Data fix has been provided to deactivate users from all the cjams user profile realted tables
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/


update userprofile set activeflag = 0, updatedby = 'CDM-39114', updatedon = now() 
where securityusersid in ('3ade3068-db0c-41bb-a0a0-942293ac0abd','7f16e8da-253a-4351-a023-19f23cdfb45d') and activeflag = 1;
update muser set activeflag = 0, updatedby = 'CDM-39114', updatedon = now() 
where securityusersid in ('3ade3068-db0c-41bb-a0a0-942293ac0abd','7f16e8da-253a-4351-a023-19f23cdfb45d')  and activeflag = 1;
update cjams.securityusers set activeflag=0, updatedby='CDM-39114', updatedon=now()  
where securityusersid in ('3ade3068-db0c-41bb-a0a0-942293ac0abd','7f16e8da-253a-4351-a023-19f23cdfb45d') and activeflag = 1;
update cjams.teammemberassignment set activeflag=0, updatedby='CDM-39114', updatedon=now() 
where securityusersid in ('3ade3068-db0c-41bb-a0a0-942293ac0abd','7f16e8da-253a-4351-a023-19f23cdfb45d') and activeflag = 1;
update rolemapping set activeflag = 0, updatedby = 'CDM-39114', updatedon = now() 
where principalid in ('14358', '5151') and activeflag = 1;
update userresource set activeflag = 0, updatedby = 'CDM-39114', updatedon = now() 
where userid in (14358,5151) and activeflag = 1;
update teammember set activeflag = 0, updatedby = 'CDM-39114', updatedon = now()
where teammemberid in ('8b877583-2315-4b35-bee6-b7725ac3eb92','66626edf-5d96-4462-a19f-ce0a3731b592') and activeflag=1; 
