/*
   Issue Description: CDM-24951
   Category/ Module  : Service Case Removal
   Root cause: User requested to remove service case opened in error 
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

Update routing set 
updatedby = 'CDM-24951', updatedon = now(),
activeflag =0
WHERE routingid  = '435a21b6-66d7-4561-88cf-c4d406e01812' 
and activeflag !=0;