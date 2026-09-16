/*
   Issue Description: CDM-28080
   Category/ Module  : Worker still showing in workload
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    teammemberid = '0552883c-5122-4098-a1a6-1eac8a5c648a';

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    securityusersid = 'e4aa8750-b783-4b5c-9d04-15e51b623451';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    securityusersid = 'e4aa8750-b783-4b5c-9d04-15e51b623451';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    securityusersid = 'e4aa8750-b783-4b5c-9d04-15e51b623451';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    principalid IN ('5186', '12415');

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    securityusersid = 'e4aa8750-b783-4b5c-9d04-15e51b623451';

update
    as_teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-28080',
    updatedon = now()
where
    securityusersid = 'e4aa8750-b783-4b5c-9d04-15e51b623451';