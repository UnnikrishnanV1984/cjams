/*
   Issue Description: CDM-42976 Zalika Pierce needs to be deleted from the workload drop down list in In Home 2. Her account has been suspended in Sailpoint but her name is still in CJAMS.
   Category/ Module  :  user management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:   zalika.pierce@montgomerycountymd.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-42976
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-42976',
    updatedon = now() 
    where email in ('zalika.pierce@montgomerycountymd.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-42976',
    updatedon = now() 
    where email in ('zalika.pierce@montgomerycountymd.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-42976', 
    updatedon = now() 
    where principalid in ('4748')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-42976', 
    updatedon = now() 
    where userid in ('4748')
    and activeflag = 1;    

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-42976', 
    updatedon = now()
    where securityusersid in('af960025-c1d4-4826-9403-b3066e6dc293')
    and activeflag=1;

    update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-42976', 
    updatedon = now()
    where securityusersid in('af960025-c1d4-4826-9403-b3066e6dc293')
    and activeflag=1;

    update securityusers
    set activeflag = 0,
    updatedby = 'CDM-42976', 
    updatedon = now()
    where securityusersid in('af960025-c1d4-4826-9403-b3066e6dc293')
    and activeflag=1;


    update teammember
    set activeflag = 0,
    updatedby = 'CDM-42976', 
    updatedon = now()
    where teammemberid in('8ee80231-91fe-4958-993a-38221903dfb7')
    and activeflag=1;

