/*
   Issue Description: CDM-28566
   Category/ Module  : Data fix
   Root cause: Skip Timer window not appearing, soft deleting the routing id to fix the issue.
   Pull request# for code fix: It's a prod data fix
   Reason why no related code fix:  
   
*/



update routing set activeflag = 0, updatedby = 'CDM-28566', updatedon = now() where routingid = 'b07c9a28-864f-45e2-9b78-adfa8a5e889a';

