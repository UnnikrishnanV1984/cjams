
/*
   Issue Description: CDM-14934
   Category/ Module  :  Updating the End date for person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-14934', updatedon = now() where routingid = '0e99fd70-3d02-4017-9609-1e610f62631d';
update permanencyplan set enddate = '2021-12-14 00:00:00', updatedby = 'CDM-14934', updatedon = now() where permanencyplanid = '6092943f-ee3e-4ea8-b752-4d6a7a84fc8e';
