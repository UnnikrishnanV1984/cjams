/*
   Issue Description: CIDM-9301
   Category/ Module  : Prod data fix to update with IVE worker
   Root cause: Data fix to update the IVE worker
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 769bdaba-c2a0-4757-a294-9d0375dc5882   
UPDATE cjams.routing
SET fromsecurityusersid='6d933eed-4b25-40bf-9919-d6078ecbe3ee', updatedby = 'CIDM-9301' , updatedon = now()
WHERE routingid='b260d53e-7172-414f-a60e-e899ae307263';
