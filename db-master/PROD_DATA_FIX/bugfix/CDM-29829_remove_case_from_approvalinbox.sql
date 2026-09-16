

/*
   Issue Description: CDM-29829
   Category/ Module  : Approval Inbox
   Root cause: Remove Apporval request from user tree
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update routing set activeflag = 0, updatedby = 'CDM-29829', updatedon = now()
where objectid in ('0aa16c20-1b58-4cf7-bf50-d41c73b9e0d6','1821224') 
and eventcode = 'PPLR' and activeflag = 1;