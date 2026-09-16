/*
  Issue Description: CJAMS-60244 Unable to assign case closure -missing IV-E Specialist names
                     Security monitor Lisa verified and confirmed the above profiles are deactivated in sailpoint
  Category/ Module : User Management
  Root cause:The users cher.harvey2@maryland.gov and cassandra.sutton@maryland.gov have recently been assigned BEACON DOL access for these two users.This changed the roletypekey in team table and also permissions were not created in the user resource table for this users.
             Ravali and Uma worked with Nate to assign beacon role for several IV-E staff 
             Role type key did not get updated for all of them about 7-8 users and the issue is not replicable.
  Fix Provided: Data fix has been provided to correct the roles and add Beacon roles in the user resource table.
                We are also able to see the Beacon dashboard for this users now.
  Regression Impacts: N/A
  Is Code fix needed: TBD
  Code fix ticket # : TBD
  Reason why no related code fix: We are unable to replicate this issue in stage-3 after assigning the roles from sailpoint side. We are closely monitoring it for similar defects.
*/


update teammember
set roletypekey = 'IVESP',
    updatedon = now(),
    updatedby = 'CJAMS-60244'
where teammemberid in (select teammemberid from teammemberassignment where securityusersid  in ('fa141717-079e-4312-8b5f-a24c78a64b59', '642d8fd5-5615-4464-acbf-70c283c190df') and activeflag=1)
and activeflag = 1; 


INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 7034, '235417e1-1676-42c1-ad7a-5d33ea7c8c86'::uuid, 5993, NULL, 1, 'CJAMS-60244', now(), 'CJAMS-60244', now(), true, true, true, NULL);


INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 14240, '235417e1-1676-42c1-ad7a-5d33ea7c8c86'::uuid, 5993, NULL, 1, 'CJAMS-60244', now(), 'CJAMS-60244', now(), true, true, true, NULL);
