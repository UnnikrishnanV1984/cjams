
/*
   Issue Description: CDM-28673
   Category/ Module  : Approval Inbox
   Root cause: User asked to remove the record from approval inbox
   Reason why no related code fix:  Data fix
*/

update routing set activeflag = 0 , updatedby = 'CDM-28673' , updatedon = now() 
where routingid = '771fa7fb-2540-4af0-89f6-f836598208ef';
