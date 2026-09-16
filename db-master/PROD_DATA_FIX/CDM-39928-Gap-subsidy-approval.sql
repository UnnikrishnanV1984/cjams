/*
   Issue Description: CDM-39928 GAP subsidy.The rate is not updating. The subsidy rate shows under review for the period which was already paid. We are unable to update the subsidy rate
   Category/ Module  : GAP Subsidy
   Root cause: Subsidy rate has been submitted by the worker (Mavis Asare-Dwamenah) and the subsidy rate review is not available under the supervisor pending approval dashboard as 
               there is the routing record is inactive for this request
   Fix provided : Data fix has been promoted to make the routing record active in the supervisor dashboard for the GAP subsidy case 3232299
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update routing 
set activeflag=1,
    updatedby='CDM-39928',
    updatedon= now() 
    where routingid='2a5801d2-2a56-45ec-850d-69dceefd6497';