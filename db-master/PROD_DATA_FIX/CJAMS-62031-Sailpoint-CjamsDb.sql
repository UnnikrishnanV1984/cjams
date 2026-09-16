/*
  Issue Description: CJAMS-62031 please do a datafix to correct the roletypekey in the teammember table it shows as LDSSSP but it should be CWSP tenaya.williams@maryland.gov            
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to change the role the workers that are already activated from user profile related tables.
             tenaya.williams@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/


update rolemapping 
set roleid  ='2452',updatedby ='CJAMS-62031', updatedon =now()
where id = '162792467' and activeflag =1;


update rolemapping 
set activeflag  =0,updatedby ='CJAMS-62031', updatedon =now()
where id = '113573605' and activeflag =1;

update teammember  
set roletypekey  ='LDSSRW',updatedby ='CJAMS-62031', updatedon =now(),teamid ='e21ae971-ab69-4a94-a824-96cb88423e48'
where teammemberid in ('3f6dd311-f75e-4a18-8075-6e2a84ae6f4a') and activeflag =1
;

update userresource  
set activeflag  =0,updatedby ='CJAMS-62031', updatedon =now()
where userresourceid in ('a56862f6-f393-4464-889a-98bf830139ff'
,'aa89b1d2-785d-4d49-be73-5d2d44855cb7','89441b2e-7b84-4a29-9e7c-0ebc1ef089fb') and activeflag =1;



