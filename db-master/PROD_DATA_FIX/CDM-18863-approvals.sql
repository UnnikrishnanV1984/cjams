/*
   Issue Description: CDM-18863
    Case Pending approval which should be removed.
   Category/ Module  :  approvals
   Root cause: user have a pending approval need to be removed
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-18863', updatedon = now() where routingid = 'bb99febb-7b54-4d36-8f8e-ee51d45663bd';