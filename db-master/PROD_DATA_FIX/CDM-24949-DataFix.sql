
/*
   Issue Description: CDM-24949
   Category/ Module  : Service Case Removal
   Root cause: User requested to remove service case opened in error 
   Pull request# for code fix: 
   Reason why no related code fix: 
*/
Update routing set 
updatedby = 'CDM-24949', updatedon = now(),
activeflag =0
WHERE routingid  = 'ff629944-47d0-4e35-b86c-bbbadedbee93' 
and activeflag !=0;