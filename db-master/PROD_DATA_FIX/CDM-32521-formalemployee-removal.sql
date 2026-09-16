/*
 Issue Description: CDM-32521
 Category/ Module  : delete former employee name from workload
 Root cause: user wants to delete
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Case is closed without closing removal and placement. Need to do data fix
 */

 
update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = 'd037b58a-ddfa-44ad-b55f-32af17914c94'
    and teammemberassignmentid = 'c9820f12-7d52-4d76-b207-a178c4a723d4';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = 'd037b58a-ddfa-44ad-b55f-32af17914c94';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = 'd037b58a-ddfa-44ad-b55f-32af17914c94';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    principalid = '14366';
    

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = 'd037b58a-ddfa-44ad-b55f-32af17914c94';

    update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = '0cf2bf33-55c7-4e4b-9995-a23a3f764285'
    and teammemberassignmentid = 'c9820f12-7d52-4d76-b207-a178c4a723d4';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = '0cf2bf33-55c7-4e4b-9995-a23a3f764285';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = '0cf2bf33-55c7-4e4b-9995-a23a3f764285';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    principalid = '14858';
   

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-32521',
    updatedon = now()
where
    securityusersid = '0cf2bf33-55c7-4e4b-9995-a23a3f764285';