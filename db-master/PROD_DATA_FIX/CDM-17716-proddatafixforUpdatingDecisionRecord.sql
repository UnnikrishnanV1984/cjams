
/*
   Issue Description: CDM-17716
   Category/ Module  : Updating the approved by Record
   Root cause: user requeseted to remove it
   Pull request# for code fix:   
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 11c49ec3-6a5b-4b09-a78a-ccaab244de50
update routing set fromsecurityusersid = 'ba51d587-d94f-4b54-8225-78af2eab1214', updatedby = 'CDM-17716', updatedon = now() where routingid = 'fc76e464-c12d-4258-bbf8-20a3fa038985';