/*
   Issue Description: CDM-30396
   Category/ Module  : Case pending approval tab
   Root cause: approved case appeared in pending inbox
   Pull request# for code fix: 8653
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-30396' 
where routingid = '87420e46-ccee-4ce8-9060-722b2fb28209';