
/*
   Issue Description: CDM-15112
   Category/ Module  :  Updating the Exit date for Removal Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing set activeflag = 0, updatedby = 'CDM-15112', updatedon = now() where routingid in ('bb0d6e45-679f-4116-a463-aae767455694','f2ca4bb8-98c8-4d64-bbd9-780db5d7f745');