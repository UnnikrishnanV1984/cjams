/*
 Issue Description:  CDM-42521
 Category/ Module: Assignments
 Root cause: Request to deactivate the user in cjams db as it is already deactivated in 
 sailpoint
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

 update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where
    securityusersid = 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0'
    and activeflag = 1;

    
update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where
    securityusersid = 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0'
    and activeflag = 1;


update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where
    securityusersid = 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0'
    and activeflag = 1;


    update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where
    securityusersid = 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0'
    and activeflag = 1;

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where
    teammemberid = '06c45b23-664a-4994-8075-16f5b3e65885'
    and activeflag = 1;

    update 
   userprofileaddress 
set 
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where securityusersid = 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0' 
and activeflag = 1;

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-42521',
    updatedon = now()
where
    principalid = '11924' 
   and roleid = 36
   and activeflag = 1;

update teammember set roletypekey = 'CWSP',
updatedby = 'CDM-42521',
updatedon = now()
where teammemberid = 'fc12c265-062b-4738-b63b-8244051e2bdb' and activeflag = 1;
