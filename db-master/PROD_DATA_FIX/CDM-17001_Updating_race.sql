/*
   Issue Description: CDM-17001
   Category/ Module  : Updating Race of user
   Root cause:User Race was not updated 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/




update personracetypemap set racetypekey = 'BA', updatedby = 'CDM-17001', updatedon = now() where personid = '3631cb6d-6a9e-4c67-ae09-7a00a6957c45';
