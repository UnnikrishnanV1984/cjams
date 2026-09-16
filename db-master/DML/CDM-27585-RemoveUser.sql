/*
   Issue Description: CDM-27585
   Category/ Module  : delete member from workload
   Root cause: user wants to delete
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update teammemberassignment
set activeflag = '0', updatedby = 'CDM-27585', updatedon = now()
where securityusersid = '5c6fbbb0-5e8c-4859-b947-b24cc586399d' and teammemberassignmentid = 'cb2fa4a4-90e8-497f-82c0-5e3ae4371ee9';

update muser set activeflag = '0', updatedby = 'CDM-27585', updatedon = now()
where securityusersid = '5c6fbbb0-5e8c-4859-b947-b24cc586399d';
    
update userprofile set activeflag = '0', updatedby = 'CDM-27585', updatedon = now()
where securityusersid = '5c6fbbb0-5e8c-4859-b947-b24cc586399d';

update rolemapping set activeflag = '0', updatedby = 'CDM-27585', updatedon = now()
where principalid = '12180' and teamtypekey = 'CW' and id = '23705513';
    
update securityusers set activeflag = '0',updatedby = 'CDM-27585', updatedon = now()
where securityusersid = '5c6fbbb0-5e8c-4859-b947-b24cc586399d';