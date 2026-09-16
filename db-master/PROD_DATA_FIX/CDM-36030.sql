-- Issue Description: 
--CDM-36030
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.				


update routing set activeflag=1,
 updatedby='CDM-36030',updatedon=now() 
where objectid='2803947' and 
routingid='5e8e3ff3-0355-4f4d-82d9-921749642e5d';
