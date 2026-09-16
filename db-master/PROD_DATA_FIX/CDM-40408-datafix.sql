/*
  Issue Description:  CDM-40408- User not able to search persons in person tab.
   Category/ Module  :  Application
   Root cause: User role change
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update teammember 
set roletypekey ='CWCW',updatedby ='CDM-40408',updatedon =now()
where teammemberid='4fea4502-3053-47c5-9aa1-666dfa7ceaa1' and activeflag =1;

update rolemapping 
set roleid =71, updatedby ='CDM-40408',updatedon =now()
where principalid ='42699' and activeflag =1;