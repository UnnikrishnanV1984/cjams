
/*
   Issue Description: CDM-31347
   Category/ Module  :  Removing records from Case Pending Approval
   Root cause:  Removing records from Case Pending Approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-31347', updatedon = now() where routingid='a6b12558-737a-4415-9f05-e62bd220d330';