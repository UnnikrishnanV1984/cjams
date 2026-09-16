/*
   Issue Description: CDM-27364
   Category/ Module  : Role 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
---User complaints about routing is not working when we investigate it has issue with his role so updating correct roles 


update cjams.teammember set roletypekey ='CWCW', updatedby ='CDM-27364', updatedon = now()
where teammemberid ='d18f4571-62ea-4a97-b2b9-ee42e427351a';

update rolemapping set activeflag =0 , updatedby ='CDM-27364', updatedon = now() where  id ='106528162';

update rolemapping set activeflag =1 , updatedby ='CDM-27364', updatedon = now() where  id ='106251508';
