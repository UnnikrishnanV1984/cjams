/*
 Issue Description: CDM-44249
-- Category/ Module: Approval
-- Root cause: re-routing the Annual Review approval request for 
Case #3196866 /CJAMS PID #201015696 to the new assigned supervisor (stephanie.meyer@maryland.gov)
-- Fix Provided: Datafix has been promoted to ruled out the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/


update routing set tosecurityusersid  = 'b89bcad8-25d0-471a-bd84-47f42d81164e',
updatedby = 'CDM-44249', updatedon = now()
where routingid = 'd4c96c29-e9de-497b-9703-34cda6363fad'
and activeflag  = 1;