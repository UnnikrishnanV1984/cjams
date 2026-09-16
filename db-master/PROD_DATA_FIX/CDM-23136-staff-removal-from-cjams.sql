/*
   Issue Description: CDM-23136
   Category/ Module  : delete member from workload Independent Living #8
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
    updatedby = 'CDM-23136',
    updatedon = now()
where
    securityusersid = 'aad5e7d2-4278-4b8c-aef8-774fa49e7887'
    and teammemberassignmentid = '31c46478-4a53-4483-80f9-f70c913a3792';


update
    muser 
set
    activeflag = '0',
    updatedby = 'CDM-23136',
    updatedon = now()
where
    securityusersid = 'aad5e7d2-4278-4b8c-aef8-774fa49e7887';
    
    
update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-23136',
    updatedon = now()
where
    securityusersid = 'aad5e7d2-4278-4b8c-aef8-774fa49e7887';
    
    
update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-23136',
    updatedon = now()
where
    principalid = '7413'
    and teamtypekey = 'CW'
    and id = '23519482';
 
    
update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-23136',
    updatedon = now()
where
    securityusersid = 'aad5e7d2-4278-4b8c-aef8-774fa49e7887';