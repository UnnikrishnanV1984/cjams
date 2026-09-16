/*
 Issue Description: CDM-16555
 Category/ Module  : delete member from workload fostercare#2 
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
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'eb82a77d-35b9-4f06-b785-a2e9ffa3595e'
    and teammemberassignmentid = 'e8145fec-f696-483d-8a6c-9243f87f7cb7';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'eb82a77d-35b9-4f06-b785-a2e9ffa3595e';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'eb82a77d-35b9-4f06-b785-a2e9ffa3595e';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    principalid = '3407'
    and teamtypekey = 'CW';

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'eb82a77d-35b9-4f06-b785-a2e9ffa3595e';