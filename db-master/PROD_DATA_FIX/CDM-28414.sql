 /*
  Issue Description: CDM-28414  Previous Support Ticket Requests
   Category/ Module  :  User management
   Root cause: Rolee not updated correctly
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
update rolemapping set roleid=1053, updatedby='CDM-28414', updatedon=now()  where principalid='12408'
and teamtypekey='CW'
and id =26195928;

update teammember set roletypekey='FNSFS', updatedby='CDM-28414', updatedon=now()  where
teammemberid='3162ff9c-8300-4fb1-af68-2e1722ac6a1f';