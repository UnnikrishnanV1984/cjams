/*
   Issue Description: CDM-18525
   Category/ Module  :  Backlogged Approval
   Root cause: user wants pending approvals to be removed
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing set activeflag =0, updatedby = 'CDM-18525', updatedon = now() where routingid = '9b08ae41-de53-4fb9-825f-4a94a481da1e' and routingstatustypeid =15 and activeflag=1;
