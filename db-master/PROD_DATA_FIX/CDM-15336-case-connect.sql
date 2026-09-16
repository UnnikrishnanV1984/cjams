/*
   Issue Description: CDM-15336
   Category/ Module  :  child welfare - Case Connect 
   Root cause: User error case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/

select * from cjams.createservicecase('4f099bec-7531-4de7-af2d-e83e837a7ccb','1eae8872-1fab-4926-a4fd-b858b6f75f79', 0, '0f8fbcb4-bc95-4005-9c54-4747eb2dc6b6', 'intake');
