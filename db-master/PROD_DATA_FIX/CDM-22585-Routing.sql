/*
   Issue Description: CDM-22585
   Category/ Module  : Need to remove the Perminancy Plan pending approval
   Root cause: user wants to remove the records
   Pull request# for code fix: checked with different case it was working as expected 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--- for this both records routingstatustypeid 16 and activeflage 1 is inserted 

update routing set activeflag =0, updatedby ='CDM-22585', updatedon =now()

where routingid in ('3e1cd1bb-5563-4017-9dcc-eaf7fd2c70e8','9522f040-ec89-497f-8446-4c395804edee');