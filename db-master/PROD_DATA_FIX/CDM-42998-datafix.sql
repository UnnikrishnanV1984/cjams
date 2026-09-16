/*
 Issue Description:  CDM-42998
 Category/ Module: Assignments
 Root cause: Request to deactivate mayerling.gamis@montgomerycountymd.gov in cjams db as it is already deactivated in 
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
    updatedby = 'CDM-42998',
    updatedon = now()
where
    securityusersid = '77fd2ef7-7224-47c0-b4f0-cf627ab40a1d'
    and activeflag = 1;

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-42998',
    updatedon = now()
where
    securityusersid = '77fd2ef7-7224-47c0-b4f0-cf627ab40a1d'
    and activeflag = 1;

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-42998',
    updatedon = now()
where
    securityusersid = '77fd2ef7-7224-47c0-b4f0-cf627ab40a1d'
    and activeflag = 1;

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-42998',
    updatedon = now()
where
    securityusersid = '77fd2ef7-7224-47c0-b4f0-cf627ab40a1d'
    and activeflag = 1;

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-42998',
    updatedon = now()
where
    teammemberid = '24ac48f4-82ef-4317-a2cb-da2eb987a159'
    and activeflag = 1;

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-42998',
    updatedon = now()
where
    principalid = '4799' 
    and activeflag = 1;

update 
   userprofileaddress 
set 
    activeflag = '0',
    updatedby = 'CDM-42998',
    updatedon = now()
where securityusersid = '77fd2ef7-7224-47c0-b4f0-cf627ab40a1d' 
and activeflag = 1;
