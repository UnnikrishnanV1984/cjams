/*
   Issue Description: CDM-34718
   Category/ Module  : Services
   Root cause: user requested to remove  ServicePlan created in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

  
update serviceplan 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-34718'
        where serviceplanid = '43034e5d-f40a-4653-9a5d-254a3183a047';