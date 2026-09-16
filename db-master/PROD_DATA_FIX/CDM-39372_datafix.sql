/*
   Issue Description: CDM-39372
   Category/ Module  : Assignments
   Root cause: The worker, Joshua Hazelwood, continues to appear in the In home Unit worker dropdown list and needs to be removed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update teammemberassignment
set activeflag=0, updatedon = now(), updatedby = 'CDM-39372'
where securityusersid in ('e22edb66-fce8-4b6c-8354-0ffe5e724d4a');

update rolemapping
set activeflag =0,
updatedby = 'CDM-39372',
    updatedon = now()
    where  principalid  ='4108'
    and id='136179102' and activeflag =1;
   
update teammember 
set activeflag =0,
updatedby = 'CDM-39372',
    updatedon = now()
    where teammemberid ='db3f6865-01d5-4831-961d-7a96d46f755c' and activeflag =1;