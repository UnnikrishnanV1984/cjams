/*
   Issue Description: CDM-18422
   Category/ Module  : Duplication of placement request
   Root cause: Data Fix
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

Update placementrevision set activeflag =0, updatedby = 'CDM-18422', updatedon = now()
where placementid = '0bd56a46-daae-4ced-860f-37bc4a5cbed0'
and placementrevisionid  = 'f06d5c61-6a03-4861-a2fd-33b9ddd1a7f9'
and activeflag  = 1;

update routing set activeflag =0, updatedby = 'CDM-18422', updatedon = now()
where objectid = '0bd56a46-daae-4ced-860f-37bc4a5cbed0'
and routingid = '7a5a80b8-6ad1-46e5-9ae5-13138d56c0a9'
and activeflag = 1;
