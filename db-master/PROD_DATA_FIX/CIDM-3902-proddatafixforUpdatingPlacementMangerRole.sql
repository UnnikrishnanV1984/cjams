
/*
   Issue Description: CIDM-3902
   Category/ Module  : Updating ROLE ID for the users
   
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- 2451 userid 3261
-- 5985 userid 14032
update userresource set roleid = '5985', updatedby = 'CIDM-3902', updatedon = now() where permissiongroupid = '7e53df93-9632-4dcb-9e35-c580f1d5680e';
