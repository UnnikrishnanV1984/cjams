/*
   Issue Description: CDM-15710
   Category/ Module  :  child welfare 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set activeflag = 0, updatedby = 'CDM-15710', updatedon = now() 
where routingid in ('5ab236fd-e965-4381-a675-73e492f434e6', 'd3a37522-efd3-4ff2-ba87-4769f81b7fcb');