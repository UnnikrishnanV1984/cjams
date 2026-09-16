/*
   Issue Description: CDM-34934
   Category/ Module  : APPROVAL INBOX
   Root cause: routing table activeflagis 1 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing set activeflag =0,updatedby='CDM-34934',updatedon=now() where 
routingid='fe3bd32e-752f-4ca6-9199-372fea40682f';