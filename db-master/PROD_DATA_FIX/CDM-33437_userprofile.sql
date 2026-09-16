/*
  Issue Description: CDM-33437 Deactivated person incorrectly showing in workload
   Category/ Module:  user management
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email: nicole.kent@maryland.gov
-- id : 14857	01bfcef7-76e8-4a75-a698-165d050b3446

update userprofile set activeflag = 0, updatedby = 'CDM-33437', updatedon = now() where securityusersid = '01bfcef7-76e8-4a75-a698-165d050b3446' and email = 'nicole.kent@maryland.gov';
update muser set activeflag = 0, updatedby = 'CDM-33437', updatedon = now() where securityusersid = '01bfcef7-76e8-4a75-a698-165d050b3446' and email = 'nicole.kent@maryland.gov';
update rolemapping set activeflag = 0, updatedby = 'CDM-33437', updatedon = now() where principalid = '14857' ;
update teammemberassignment set activeflag =0, updatedby = 'CDM-33437', updatedon = now() where securityusersid = '01bfcef7-76e8-4a75-a698-165d050b3446';
update cjams.securityusers set  activeflag=0, updatedby='CDM-33437', updatedon=now()  where securityusersid='01bfcef7-76e8-4a75-a698-165d050b3446';
update cjams.userresource set  activeflag=0, updatedby='CDM-33437', updatedon=now() where userid ='14857' and activeflag=1;