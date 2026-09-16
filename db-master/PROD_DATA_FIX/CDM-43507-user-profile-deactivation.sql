/*
   Issue Description: CDM-43507 julia.jensen@maryland.gov is still able to approve invoices following a role removal.
   Category/ Module  :  user management
   Root cause: User Julia Jensen deactivated as per sail point. Data fix needed to deactivate the user in userresource related table.
   User list:   julia.jensen@maryland.gov
   Fix Provided: Data fix to Soft delete the users from  user resource,userprofileaddress and securityusers tables for user profile deactivation.
   Data/Code fix ticket#: CDM-43507
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/


update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-43507', 
    updatedon = now() 
    where userid in ('2763')
    and activeflag = 1;    

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-43507', 
    updatedon = now()
    where securityusersid in('80025a81-dad5-4345-80d1-f97bddb1dbbc')
    and activeflag=1;

    
update securityusers
    set activeflag = 0,
    updatedby = 'CDM-43507', 
    updatedon = now()
    where securityusersid in('80025a81-dad5-4345-80d1-f97bddb1dbbc')
    and activeflag=1;
