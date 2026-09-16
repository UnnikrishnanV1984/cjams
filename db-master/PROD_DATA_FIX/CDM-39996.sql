/*
 Issue Description: CDM-39996
-- Category/ Module: FinanceAccountsPayable/Funding approval
-- Root cause: Purchase authorization status is empty and Funding approval date is empty in Funding approval due to data error.
-- Fix Provided: Datafix has been promoted to update active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing
set
activeflag = 1,
updatedby = 'CDM-39996',
updatedon = now()
where
routingid = '25966b76-6e1f-4e99-9c1c-adcbb0e3856c'
and objectid = '3275753'
and activeflag = 0;
