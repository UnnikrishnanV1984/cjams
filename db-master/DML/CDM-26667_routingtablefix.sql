/*
   Issue Description: CDM-26667
   Category/ Module  : Approval Inbox
   Root cause: Remove Apporval request from user tree
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update routing set activeflag = 0, updatedby = 'CDM-26667', updatedon = now()
where routingid = 'e87fe1b1-1089-492f-8fe1-847c5b5ab6c0';
