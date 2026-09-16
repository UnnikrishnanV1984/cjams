
/*
  Issue Description:CDM-39957 CJAMS Access Removal-Amber Frock.
  Category/ Module : User Management
  Root cause: Users are already deactivated in sailpoint. Please do a datafix and deactivate the below users from all user tables in cjams db
  Fix Provided: Data fix has been provided to deactivate users from all the cjams user profile realted tables
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A

*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-44161',
    updatedon = now() 
    where email in ('pamela.abramson@montgomerycountymd.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-44161',
    updatedon = now() 
    where email in ('pamela.abramson@montgomerycountymd.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-44161', 
    updatedon = now() 
    where principalid in ('14038')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-44161', 
    updatedon = now() 
    where userid in ('14038')
    and activeflag = 1;    

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-44161', 
    updatedon = now()
    where securityusersid in('390fe84f-bf06-4f80-9795-065f4d170df3')
    and activeflag=1;

    update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-44161', 
    updatedon = now()
    where securityusersid in('390fe84f-bf06-4f80-9795-065f4d170df3')
    and activeflag=1;

    update securityusers
    set activeflag = 0,
    updatedby = 'CDM-44161', 
    updatedon = now()
    where securityusersid in('390fe84f-bf06-4f80-9795-065f4d170df3')
    and activeflag=1;


    update teammember
    set activeflag = 0,
    updatedby = 'CDM-44161', 
    updatedon = now()
    where teammemberid in('83c8b288-283c-4777-89f1-f60629163c77')
    and activeflag=1;