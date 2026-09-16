/* 
   Issue Description: CDM-41514 Previous intern still in CJAMS
   Category/ Module  : user management
   Root cause: Data fix needed to Offboarding Prior intern, Sarah Vaughn who is still in cjams.
   Fix Provided : Data fix has been provided Deactive the users from user profile related tables.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41514'
where securityusersid in ('19b13fb9-e7cd-461a-8c0b-4d987b3a9c4b');

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41514'
where securityusersid in ('19b13fb9-e7cd-461a-8c0b-4d987b3a9c4b');

update rolemapping
set activeflag = 0, updatedby = 'CDM-41514', updatedon = now() 
where principalid in ('28721') and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-41514', updatedon = now() 
where userid in (28721) and activeflag = 1;

update teammemberassignment 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41514'
where securityusersid in ('19b13fb9-e7cd-461a-8c0b-4d987b3a9c4b');

update securityusers 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41514'
where securityusersid in ('19b13fb9-e7cd-461a-8c0b-4d987b3a9c4b');

update teammember set activeflag = 0, updatedby = 'CDM-41514', updatedon = now()
where teammemberid in ('c1f66578-8315-439a-a34a-6e7944ce7fc3') and activeflag = 1;