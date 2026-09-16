/*
   Issue Description: CDM-20625
   Category/ Module  : Case pending Approval
   Root cause: user wants to remove the approval record still shown in inbox 
   Pull request# for code fix: 4902
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix.
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-20625' 
where routingid = '2b04bf6a-d73a-49d7-8c2d-3c3b93f1b5ae';