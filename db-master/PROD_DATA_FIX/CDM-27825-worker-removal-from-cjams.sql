/*
   Issue Description: CDM-27825
   Category/ Module  : Worker Removal from CJAMS
   Root cause: user wants to delete below users
    niketa.myers1@maryland.gov
    stacy.embrack@maryland.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    teammemberid in (
        '09163d9a-ae3c-4ae0-9145-161c53eec09a',
        '23d51a0c-f3ff-479a-8ba4-8b7de85c99e2'
    );

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    securityusersid IN (
        'f0815d7c-e8b8-4f1f-b195-6d35a097cf55',
        'b68144cc-5db5-45f7-84fd-d07e2798cbd1'
    );

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    securityusersid IN (
        'f0815d7c-e8b8-4f1f-b195-6d35a097cf55',
        'b68144cc-5db5-45f7-84fd-d07e2798cbd1'
    );

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    securityusersid IN (
        'f0815d7c-e8b8-4f1f-b195-6d35a097cf55',
        'b68144cc-5db5-45f7-84fd-d07e2798cbd1'
    );

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    principalid IN ('5186', '12415');

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    securityusersid IN (
        'f0815d7c-e8b8-4f1f-b195-6d35a097cf55',
        'b68144cc-5db5-45f7-84fd-d07e2798cbd1'
    );

update
    as_teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-27825',
    updatedon = now()
where
    securityusersid = 'b68144cc-5db5-45f7-84fd-d07e2798cbd1';