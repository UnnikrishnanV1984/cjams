/*
   Issue Description: CJAMS-59183 Duplicate Sailpoint accounts
   Category/ Module  : User Management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:  michelle.olson@maryland.gov
               michelle.olson1@maryland.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CJAMS-59183
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
   set activeflag = 0, 
       updatedby = 'CJAMS-59183',
       updatedon = now() 
    where securityusersid in ('eb2cd555-cb95-4d91-8b03-16b0fb24607e','44f698fb-d7c1-472c-82c0-bc33171feee2')
    and activeflag=1;

update muser 
   set activeflag = 0, 
       updatedby = 'CJAMS-59183',
       updatedon = now() 
    where securityusersid in ('eb2cd555-cb95-4d91-8b03-16b0fb24607e','44f698fb-d7c1-472c-82c0-bc33171feee2')
    and activeflag=1;

update rolemapping 
   set activeflag = 0, 
       updatedby = 'CJAMS-59183', 
       updatedon = now() 
    where principalid in ('45496','56929')
    and activeflag = 1;

   
update userprofileaddress
    set activeflag = 0,
        updatedby = 'CJAMS-59183', 
        updatedon = now()
    where securityusersid in ('eb2cd555-cb95-4d91-8b03-16b0fb24607e','44f698fb-d7c1-472c-82c0-bc33171feee2')
    and activeflag=1;        

update teammemberassignment
    set activeflag = 0,
        updatedby = 'CJAMS-59183', 
        updatedon = now()
    where securityusersid in ('eb2cd555-cb95-4d91-8b03-16b0fb24607e','44f698fb-d7c1-472c-82c0-bc33171feee2')
    and activeflag=1;

update securityusers
    set activeflag = 0,
       updatedby = 'CJAMS-59183', 
       updatedon = now()
    where securityusersid in ('eb2cd555-cb95-4d91-8b03-16b0fb24607e','44f698fb-d7c1-472c-82c0-bc33171feee2')
    and activeflag=1;

update teammember
    set activeflag = 0,
        updatedby = 'CJAMS-59183', 
        updatedon = now()
    where teammemberid in ('0d44bec8-74d9-4409-b14c-5c3125724dc3','685ea915-ad22-4885-a594-b33073f91698')
    and activeflag=1;
    
      
   
