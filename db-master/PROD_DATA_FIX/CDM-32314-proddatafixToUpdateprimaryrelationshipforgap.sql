/*
   Issue Description: CDM-32497
   Category/ Module  : Prod data fix to update document user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--DACRCHLD
--DACRCHLD
update guardianship set primaryrelationshipkey = 'PRNTLGPRNT', secondaryrelationshipkey = 'PRNTLGPRNT', updatedby = 'CDM-32314', updatedon = now()
where gapid in ('860e3895-3163-419e-8319-23b015149aaa', '644d9bad-5db0-448d-a86c-e49017f2a423'); 
