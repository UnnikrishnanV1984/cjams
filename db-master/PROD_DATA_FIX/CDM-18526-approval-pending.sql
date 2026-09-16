/*
   Issue Description: CDM-18526
   Category/ Module  : pending approval
   Root cause: approval pending
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-18526', updatedon = now() where routingid = '422f72bb-1f31-4480-a50b-4da77aa41af0' and routingstatustypeid =15;