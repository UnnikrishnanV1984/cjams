/*
   Issue Description: CDM-33985
   Category/ Module  : Services
   Root cause: user requested to remove  ServicePlan created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  
update serviceplan 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-33985'
        where serviceplanid = '64f7aacb-8d49-49ba-9200-553dc9782b47';