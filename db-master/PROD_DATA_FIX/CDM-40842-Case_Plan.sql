
/*
 Issue Description: CDM-40842
-- Category/ Module: Pending Approval
-- Root cause: User wants to remove case pending approval.
-- Fix Provided: Datafix has been promoted to update active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing
set activeflag = 0,
    updatedby = 'CDM-40842',
    updatedon  =  now()
where objectid = '43873540-e4cb-4bc1-ac7a-2ce082fbf191'
and routingid = 'c84437ab-d26d-43af-83de-9bb8cfec5706';
