/*
  Issue Description: CDM-20039 Supervisor Role
   Category/ Module  :  user management
   Root cause: User is having only CJAMS_CWCASEWORKER(71) role not the CJAMS_CWSUPERVISOR (36)role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: roleid= 71 , roletypekey = 'CWCW' 
*/
-- email:Susan.Tossman1@maryland.gov ,id :13347

update rolemapping set roleid =36, updatedby ='CDM-20039', updatedon = now() where principalid = 13347 and id =42314614; 

update teammember set roletypekey = 'CWSP', description='Supervisor,CW' , updatedby ='CDM-20039' , updatedon = now() where teammemberid = '3310d6b4-87ec-4315-b268-27f7f818787c';
