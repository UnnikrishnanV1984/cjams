/*
   Issue Description: CDM-16653
   Category/ Module  : remove staff
   Root cause: User asked to change findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-16653',
    updatedon = now()
where
    securityusersid = 'a34042b1-3c95-420c-b67f-b2fe2dff7c1d'
    and teammemberassignmentid = '4cd967b6-8ee3-4ee5-b7bd-a09962ed5298';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'a34042b1-3c95-420c-b67f-b2fe2dff7c1d';


update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'a34042b1-3c95-420c-b67f-b2fe2dff7c1d';


update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    principalid = '11994'
    and activeflag = '1';


update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'a34042b1-3c95-420c-b67f-b2fe2dff7c1d' ;
    
    
    
    
---------------------------------------------------------

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-16653',
    updatedon = now()
where
    securityusersid = 'da40baee-19f8-4028-b305-aa36e0ef7252'
    and teammemberassignmentid = '46a70fad-4f43-46db-a480-077c4c8dfced';
    

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'da40baee-19f8-4028-b305-aa36e0ef7252';


update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'da40baee-19f8-4028-b305-aa36e0ef7252';


update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    principalid = '9607'
    and activeflag = '1';


update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-16555',
    updatedon = now()
where
    securityusersid = 'da40baee-19f8-4028-b305-aa36e0ef7252';