/*
   Issue Description: CDM-24109
   Category/ Module  :  Removing records from Case Pending Approval
   Root cause:  Removing records from Case Pending Approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-24109', updatedon = now() where routingid in ('270aa633-e964-4566-82bc-e390f4e15f3e', '8ef2c172-75b5-414b-a551-3be38e6dd3e6');
