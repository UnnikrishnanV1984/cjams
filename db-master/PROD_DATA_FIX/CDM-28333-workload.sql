/*
   Issue Description: CDM-28333
   Category/ Module  : Worker still showing in workload
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    teammemberid = 'ab233ed6-a84c-4a1e-839e-bc67c646de4c';

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    securityusersid = '92321473-17a6-45c2-bbaf-cffd52a7c98c';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    securityusersid = '92321473-17a6-45c2-bbaf-cffd52a7c98c';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    securityusersid = '92321473-17a6-45c2-bbaf-cffd52a7c98c';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    principalid = '13464';

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    securityusersid = '92321473-17a6-45c2-bbaf-cffd52a7c98c';

update
    as_teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-28333',
    updatedon = now()
where
    securityusersid = '92321473-17a6-45c2-bbaf-cffd52a7c98c';