/*
   Issue Description: CDM-29545
   Category/ Module  :Already Approved Plan/Approval Inbox
   Root cause: The APPLA plan has already been approved but has not been removed from my inbox. If this could be removed
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update routing set activeflag = 0 , updatedby ='CDM-29545', updatedon = now() where routingid ='bdbfc26e-2a69-450e-aecf-a4a2af7cc979';