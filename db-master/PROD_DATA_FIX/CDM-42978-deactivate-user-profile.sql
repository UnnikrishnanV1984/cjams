/*
   Issue Description: CDM-42978 The following workers need to be deleted from the workload drop down list. Their accounts have been suspended in Sailpoint but their names are still in CJAMS. Marisa Lim- LDSS Management #1 JoAnn Barnes- LDSS Management #3 Teresa Blair- Personnel Vicky Suero- Special Projects
   Category/ Module  :  user management
   Root cause: Data fix to deactivate user profiles who are inactive in sailpoint
   User list:   marisa.lim@montgomerycountymd.gov
                joann.barnes@montgomerycountymd.gov
                teresa.blair@montgomerycountymd.gov
   Fix Provided: Data fix to Soft delete the users from rolemapping, user resource, userprofile, muser,userprofileaddress,teammemberassignment,teammember and securityusers tables
   Data/Code fix ticket#: CDM-42978
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

update userprofile 
set activeflag = 0, 
    updatedby = 'CDM-42978',
    updatedon = now() 
    where email in ('marisa.lim@montgomerycountymd.gov',
                    'joann.barnes@montgomerycountymd.gov',
                    'teresa.blair@montgomerycountymd.gov')
    and activeflag=1;

update muser 
set activeflag = 0, 
    updatedby = 'CDM-42978',
    updatedon = now() 
    where email in ('marisa.lim@montgomerycountymd.gov',
                    'joann.barnes@montgomerycountymd.gov',
                    'teresa.blair@montgomerycountymd.gov')
    and activeflag=1;

update rolemapping 
    set activeflag = 0, 
    updatedby = 'CDM-42978', 
    updatedon = now() 
    where principalid in ('4770',
                          '4786',
                          '4673')
    and activeflag = 1;

update userresource 
    set activeflag = 0, 
    updatedby = 'CDM-42978', 
    updatedon = now() 
    where userid in ('4770',
                     '4786',
                     '4673')
    and activeflag = 1;    

update userprofileaddress
    set activeflag = 0,
    updatedby = 'CDM-42978', 
    updatedon = now()
    where securityusersid in('2744f953-7397-418c-a21f-5e47fab07892',
                             '2f732c45-c0b9-4687-a94b-39032045f111',
                             '40d90111-ad67-494f-8a63-06f5990c9738')
    and activeflag=1;

    update teammemberassignment
    set activeflag = 0,
    updatedby = 'CDM-42978', 
    updatedon = now()
    where securityusersid in('2744f953-7397-418c-a21f-5e47fab07892',
                             '2f732c45-c0b9-4687-a94b-39032045f111',
                             '40d90111-ad67-494f-8a63-06f5990c9738')
    and activeflag=1;

    update securityusers
    set activeflag = 0,
    updatedby = 'CDM-42978', 
    updatedon = now()
    where securityusersid in('2744f953-7397-418c-a21f-5e47fab07892',
                             '2f732c45-c0b9-4687-a94b-39032045f111',
                             '40d90111-ad67-494f-8a63-06f5990c9738')
    and activeflag=1;


    update teammember
    set activeflag = 0,
    updatedby = 'CDM-42978', 
    updatedon = now()
    where teammemberid in('95ce4536-1116-4a6e-8bf9-911efe8bf075',
                             '7119af80-1595-41b8-967c-8d8701217ced',
                             '026173ea-2e6d-4229-8e3c-7fcb1f104ce7')
    and activeflag=1;

