/*
   Issue Description: CIDM-8438
   Category/ Module  : Prod data fix to update the decision status
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select routingstatustypeid,* from routing where objectid = 'I221010239296';

Update routing set 
routingstatustypeid = 8, updatedby='CIDM-8438', updatedon= now()
WHERE objectid = 'I231011813838';