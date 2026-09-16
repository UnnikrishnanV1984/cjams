/*
   Issue Description: CDM-33500
   Category/ Module  : Worker Removal from CJAMS
   Root cause: user wants to delete below user
    rebeccal.flanagan@maryland.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-33500',
    updatedon = now()
where
   teammemberid ='21fcab40-72fa-4bfa-9b91-9b7545b3fa1d';

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-33500',
    updatedon = now()
where
     securityusersid = '57c3a55c-1836-4d1b-b918-efeb4fdc17cb';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-33500',
    updatedon = now()
where
    securityusersid = '57c3a55c-1836-4d1b-b918-efeb4fdc17cb';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-33500',
    updatedon = now()
where
    securityusersid = '57c3a55c-1836-4d1b-b918-efeb4fdc17cb';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-33500',
    updatedon = now()
where
     principalid ='4178';

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-33500',
    updatedon = now()
where
    securityusersid = '57c3a55c-1836-4d1b-b918-efeb4fdc17cb';

