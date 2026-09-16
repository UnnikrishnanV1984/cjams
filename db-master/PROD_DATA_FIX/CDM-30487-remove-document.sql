/*
   Issue Description: CDM-30487
   Category/ Module  : Documents
   Root cause: user requested to remove the  document 0373_001.pdf 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update documentproperties set activeflag = 0, updatedby = 'CDM-30487', updatedon = now() where documentpropertiesid = '47260311-0a54-45ba-abfe-312d8c7b8de0';

update documentattachment set activeflag = 0, updatedby = 'CDM-30487', updatedon = now() where documentpropertiesid = '47260311-0a54-45ba-abfe-312d8c7b8de0';