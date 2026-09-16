/*
 Issue Description:  CDM-42975
 Category/ Module: Assignments
 Root cause: Request to deactivate ingris.gutierro-gallo@montgomerycountymd.gov in cjams db as it is already deactivated in 
 sailpoint
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-42975',
    updatedon = now()
where
    securityusersid = 'e1e596d2-e82a-4c2c-a408-e9e043699c59';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-42975',
    updatedon = now()
where
    securityusersid = 'e1e596d2-e82a-4c2c-a408-e9e043699c59';

       
update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-42975',
    updatedon = now()
where
    securityusersid = 'e1e596d2-e82a-4c2c-a408-e9e043699c59';


update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-42975',
    updatedon = now()
where
    securityusersid = 'e1e596d2-e82a-4c2c-a408-e9e043699c59';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-42975',
    updatedon = now()
where
    principalid = '39918';

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-42975',
    updatedon = now()
where
    teammemberid = '15e2ca06-fe33-4000-9b0a-d976839633f7';