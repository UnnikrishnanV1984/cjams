/*
  Issue Description: CDM-39017 Remove staff from unit
  Category/ Module : user management
  Root cause: Dan Duvall is no longer employed. He has been removed from SailPoint. He is still showing in the supervisor drop down list on workload. 
              Please removed Dan DuVall from In Home Unit 2 Screen
  Fix Provided: Data fix has been promoted to Remove the user from cjams profile related table
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- Email: dan.duvall@maryland.gov
--securityuserid: c78b17fd-5777-4c8f-8074-7efc1999e677 
-- id : 4126

update userprofile set activeflag = 0, updatedby = 'CDM-38809', updatedon = now() 
where securityusersid ='c78b17fd-5777-4c8f-8074-7efc1999e677' and activeflag=1;

update muser set activeflag = 0, updatedby = 'CDM-38809', updatedon = now() 
where securityusersid ='c78b17fd-5777-4c8f-8074-7efc1999e677' and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CDM-38809', updatedon=now()  
where securityusersid ='c78b17fd-5777-4c8f-8074-7efc1999e677' and activeflag =1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-38809', updatedon=now() 
where securityusersid ='c78b17fd-5777-4c8f-8074-7efc1999e677' and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CDM-38809', updatedon = now() 
where principalid ='4126' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CDM-38809', updatedon = now() 
where userid =4126 and activeflag = 1;


