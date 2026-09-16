/*
   Issue Description: CDM-42977 nna Jung needs to be deleted from the workload drop down list in Kinship Her account has been suspended in Sailpoint but her name is still in CJAMS. She should also be removed from all supervisor lists in CJAMS.
   Category/ Module  :  user management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:   anna.jung2@montgomerycountymd.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables
   Data/Code fix ticket#: CDM-42977
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-42977',
    updatedon = now() 
    where email in ('anna.jung2@montgomerycountymd.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-42977',
    updatedon = now() 
    where email in ('anna.jung2@montgomerycountymd.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-42977', 
    updatedon = now() 
    where principalid in ('4749')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-42977', 
    updatedon = now() 
    where userid in ('4749')
    and activeflag = 1;    

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-42977', 
    updatedon = now()
    where securityusersid in('cd0791b5-b0cd-48c4-9f30-76232793d084')
    and activeflag=1;

    update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-42977', 
    updatedon = now()
    where securityusersid in('cd0791b5-b0cd-48c4-9f30-76232793d084')
    and activeflag=1;

    update securityusers
    set activeflag = 0,
    updatedby = 'CDM-42977', 
    updatedon = now()
    where securityusersid in('cd0791b5-b0cd-48c4-9f30-76232793d084')
    and activeflag=1;


    update teammember
    set activeflag = 0,
    updatedby = 'CDM-42977', 
    updatedon = now()
    where teammemberid in('9965d813-2690-41ff-82f6-6842c430ac59')
    and activeflag=1;

