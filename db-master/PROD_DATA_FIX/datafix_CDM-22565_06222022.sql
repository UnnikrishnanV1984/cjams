/*
   Issue Description: CDM-22565
   Category/ Module  : Need to remove the Case Plan pending approval
   Root cause: user wants to remove the records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag =0, updatedby = 'CDM-22565', updatedon = now()
where routingid = '58a47b85-9394-484a-ba90-e575970bafbf';